## What is PeeWeeLinux?

PeeWeeLinux small Linux distribution for embedded applications and single floppy systems. It was developed on a Redhat 6.1 system. PeeWeeLinux was successfully deployed in some commercial projects. The distibution has not been maintained since early 2002.

There is more informations at:

*   [PeeWeeLinux Website](http://adilinden.github.io/pwlconfig/)
*   [SourceForge Project](https://sourceforge.net/projects/embedded/)

### What is pwlconfig?

PeeWeeLinux's "pwlconfig" is a menu driven, embedded Linux development tool.

With pwlconfig you can build customized "projects" that fully define a bootable Linux file system, suitable for embedding in your favorite target hardware.

Pwlconfig removes the manual "artistic" effort for building an embedded Linux system.  If you have all the individual pieces of a product working (and maybe even backed up) putting them all together *again* can be a slow, error-prone job.

By coordinating all of these pieces in one environment, backing up, rebuilding and customizing your product becomes a snap!

### pwlconfig Quick Reference

The best way to learn pwlconfig is to get your hands on it and build a simple product.  Just follow these few steps to build a bootable floppy.

Go to the Embedded_Build directory and enter:

    ./pwlconfig

You will be prompted for a project name, enter:

    simple

Next you are prompted for a project device type. You must enter one of the devices currently supported. The device type must be accessible from pwlconfig. Enter:

    FLOPPY

(or "DOC", "FLASH" or CDROM for Disk-On-Chip, flash disk device or CD-ROM)

The main menu displayed lets you create your own file system based on Pee Wee Linux packages and your own custom files.  So, from here, select Configure Project File System.

This menu displays the packages and package categories provided with Pee Wee Linux. Choose the first package to configure that one. Cursor down to boot_system and press Enter.

The "Configure Packages Menu" displayed lists all the files contained within this package.  Cursor to any file and 'select' it to exclude or include it as part of your file system.

Now press ESC a couple of times until the main menu is displayed. Highlight "Extract File System from Project" and press ENTER. Accept the defaults, this will extract all files into a mount point within your "simple" project.

The main menu options "Erase..." "Load..." and "Install..." should be displayed along with the device you selected above.  Simply choose those in that order.

Erase, suprise, erases the device.  "Load..." copies the files you previously extracted onto the device.  Lilo will then format the MBR for your new file system to allow it to boot.

Various other parameters can be changed to fine tune pwlconfig for your hardware environment, should it differ from the "defaults".  Use "Manage Projects->Project defaults..." to display these defaults and change them as you like.

Thats it, you have now successfully "embedded" PeeWeeLinux !

For more in-depth information on pwlconfig see [README.pwlconfig](https://raw.githubusercontent.com/adilinden/pwlconfig/master/scripts/README.pwlconfig)
