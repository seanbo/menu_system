# menu_system

## Descrition
A configuration file based menu system to simply running tasks

## The bin directory
This is where the executable scripts reside for this package

### menu.sh
This is the main program

### global.sh
This is a file with functions used by menu.sh but can gbe shared with other script by using the bash source command

### userfunc.sh
This is a file included user defined functions that can be shared.  The file included with this packare are simply used as samples and can be removed

###
When creating sub-menus, you will create a symbolic link to menu.sh

To create a menu for backups, you woudl creat a symbolic link named backup.sh, for example.  A configuration file will also be needed.  This will be discussed in the Configuration section below
```bash
seanbo@frankenstein:~/projects/menu_system/bin$ ln -s menu.sh backup.sh
seanbo@frankenstein:~/projects/menu_system/bin$ ls -l
total 28
lrwxrwxrwx 1 seanbo seanbo    7 Oct 29 20:36 backup.sh -> menu.sh
-rwxrwxr-x 1 seanbo seanbo 2998 Oct 29 20:55 global.sh
-rwxrwxr-x 1 seanbo seanbo 1545 Oct 29 20:36 menu.sh
-rwxrwxr-x 1 seanbo seanbo  448 Oct 29 20:36 run-all.sh
-rwxrwxr-x 1 seanbo seanbo   80 Oct 29 20:36 run-sample.sh
lrwxrwxrwx 1 seanbo seanbo    7 Oct 29 20:36 sample.sh -> menu.sh
-rwxrwxr-x 1 seanbo seanbo  446 Oct 29 20:36 upgrade-packages.sh
-rwxrwxr-x 1 seanbo seanbo  646 Oct 29 20:36 userfunc.sh
-rwxrwxr-x 1 seanbo seanbo 3491 Oct 29 20:36 userfunctions.sh
```

## The cfg directory
This is where your configuration files are stored.  The only required file is menu.cfg as it is used by bin/menu.sh which is the main executable for this package

### Sub-menu configuration files
For each symbolic link you create int he bin directory, you will need a correspondin configuration file in the cfg.  In our example above, we created backup.sh.  The corresponmding configuration file would be named backup.cfg

### Configuration file format

-menutitle : This will define the title on the screen for that menu.  
  -Each configuration file is required to have a "menutitle" entry.  
  -It is not required, but then the user would not be aware which menu they were on as there would be no title at the top of the screen
  -It is not required to be the first entry, but is recommended.
  -Format: menutitle:Some Title Here:false
-menuitem : There will be one menuitem line for each item in the menu listing
  -None are required, but that would defeat the purpose, wouldn't it?
  -Format: menuitem:Some Menu Title:path to script <args>
    -If the path begins with a leadiing /, the system will use the absolute path to the script.
    -If the path does not begin with a leading slash, it will look in the menu system's bin directory for the script

As sample for a possible backup menu (cfg/backup.cfg)
```
enutitle:Backup Menu:false
menuitem:Full Backup:run_backup.sh
menuitem:Backup /boot:run_backup.sh boot
menuitem:Backup /etc:run_backup.sh etc:
menuitem:Backup /home/seanbo:run_backup.sh seanbo
menuitem:Back to Main Menu:exit:0:1
```

# Included samples
These are not required and can be removed from the bin directory and related .cfg files in the cfg directory
-bin/run-sample.sh
-upgrade-packages.sh

userfun.sh is sourced by global.sh and will result in an error if removed.  I recommend just clearing the contents of the file if you do not require and special functions.  The sample file bin/upgrade-packages.sh illustrates how one might use userfunc.sh to create and perform shared actions.


# Copyright
## Licensed under the LGPL3
Please see LICENSE.txt or COPYING.txt for license terms
