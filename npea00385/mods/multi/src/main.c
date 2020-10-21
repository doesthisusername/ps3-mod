#include <hook.h>
#include <sys.h>
#include <net.h>
#include <game.h>

struct multi_data {
    int planet;
    struct moby player;
};

int is_host;
int sock;
struct sockaddr_in partner;

struct multi_data my_data;
struct multi_data partner_data;
struct moby* partner_moby = 0;

int old_bolts;

unsigned int parse_dec(char* txt, char** endptr) {
    unsigned int num = 0;

    while(*txt >= 0x30 && *txt <= 0x39) {
        num *= 10;
        num += *txt - 0x30;
        txt++;
    }

    if(endptr) {
        *endptr = txt;
    }

    return num;
}

int fill_partner() {
    int fd;
    int err = syscall(SYS_FS_OPEN, "/dev_hdd0/game/NPEA00385/USRDIR/mod/multi/host.txt", O_RDONLY, &fd, 0, 0, 0);
    if(err != 0) {
        printf("[multi] failed to open host.txt; error %d\n", err);
        return err;
    }

    unsigned len[2];
    err = syscall(SYS_FS_LSEEK, fd, 0, SEEK_END, len);
    if(err != 0) {
        printf("[multi] failed to find length of host.txt (?); error %d\n", err);
        return err;
    }
    
    unsigned dummy[2];
    syscall(SYS_FS_LSEEK, fd, 0, SEEK_SET, dummy);

    char addr_buf[32];
    unsigned nread[2];
    err = syscall(SYS_FS_READ, fd, addr_buf, len[1], nread);
    if(err != 0) {
        printf("[multi] failed to read host.txt; error %d\n", err);
        return err;
    }
    addr_buf[nread[1]] = '\0';

    syscall(SYS_FS_CLOSE, fd);

    unsigned int ip[4];
    char* cur_txt = addr_buf;

    for(unsigned int i = 0; i < 4; i++) {
        ip[i] = parse_dec(cur_txt, &cur_txt);
        cur_txt++;
    }
    partner.sin_addr = IP(ip[0], ip[1], ip[2], ip[3]);
    partner.sin_port = parse_dec(cur_txt, 0);

    is_host = partner.sin_addr == 0;

    return 0;
}

void multi_update() {
    if(level_frame_count == 1) {
        partner_moby = 0;
    }

    // heuristic for whether it even makes sense to send/receive data, and for whether the moby should be considered gone
    if(!sock || !player_moby || should_load > 0 || player_moby->pos.z == 0.0f) {
        partner_moby = 0;
        return;
    }

    // send our data
    my_data.planet = current_planet;
    memcpy(&my_data.player, player_moby, sizeof(my_data.player));
    syscall(SYS_BNET_SENDTO, sock, &my_data, sizeof(my_data), MSG_DONTWAIT, &partner, sizeof(partner));

    // receive our data if it exists
    int paddrlen = sizeof(partner);
    int received = syscall(SYS_BNET_RECVFROM, sock, &partner_data, sizeof(partner_data), MSG_DONTWAIT, &partner, &paddrlen);
    if(partner.sin_addr == IP(127, 0, 0, 1) || received <= 0 || partner_data.planet != current_planet) {
        return;
    }

    if(!partner_moby) {
        partner_moby = spawn_moby(500); // crate
    }
    if(partner_moby) {
        // skip pointers
        memcpy(partner_moby, &partner_data.player, 0x20);
        memcpy(&partner_moby->rot, &partner_data.player.rot, sizeof(struct vec4));
        //memcpy(&partner_moby->scale, &partner_data.player.scale, 0x3C);
        //memcpy((char*)partner_moby + 0x70, (char*)&partner_data.player + 0x70, 0x08);
        //memcpy((char*)partner_moby + 0x7C, (char*)&partner_data.player + 0x7C, 0x84);

        *(unsigned*)((char*)partner_moby + 0x74) = 0; // disable tick
        partner_moby->render_distance = 0x7FFF;
    }
}

void _start() {
    sock = syscall(SYS_BNET_SOCKET, AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    if(sock <= 0) {
        printf("[multi] failed to make sock; syscall gave %d. exiting...\n", sock);
        return;
    }

    partner.sin_len = sizeof(partner);
    partner.sin_family = AF_INET;
    partner.sin_zero = 0;
    if(fill_partner()) {
        printf("[multi] failed to parse partner ip, sad\n");
        return;
    }

    if(is_host) {
        syscall(SYS_BNET_BIND, sock, &partner, sizeof(partner));
    }
    else {
        syscall(SYS_BNET_CONNECT, sock, &partner, sizeof(partner));
    }

    struct hook_info info;
    info.local_func = multi_update;
    info.target = HOOK_INPUT;
    info.priority = PRIO_NORMAL;

    hook(&info);
}
