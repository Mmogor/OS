#include "boot.h"

struct port_io_ops pio_ops;

int main(void)
{
	init_default_io_ops();
}
