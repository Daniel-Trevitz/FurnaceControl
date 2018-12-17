#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include <sys/ioctl.h>
#include <linux/i2c-dev.h>

int main (void)
{
    unsigned char value = 0xE3;
    int fd;

    fd = open("/dev/i2c-1", O_RDWR);

    if (fd < 0) {
        printf("Error opening file: %s\n", strerror(errno));
        return 1;
    }

    if (ioctl(fd, I2C_SLAVE, 0x40) < 0) {
        printf("ioctl error: %s\n", strerror(errno));
        return 1;
    }

    if (write(fd, &value, 1) < 0) {
        printf("ioctl error: %s\n", strerror(errno));
        return 1;
    }

    usleep(100000);

    char data[2];
    if (read(fd, data, 2) != 2) {
        printf("read error: %s\n", strerror(errno));
        return 1;
    }

    double cTemp = (((double)(data[0]) * 256.0 + ((double)data[1])) * 175.72 / 65536.0) - 46.85;
    double fTemp = cTemp * 1.8 + 32.0;

    printf("%.2f\n", fTemp);

    return 0;
}
