This is a hands-on class with a lab environment where you can follow along with the material and perform the lab exercises at the end of each section.

If you are not a CloudBees customer, partner, or employee, this page explains how to install and access the provided Virtual Machine to use as your CloudBees lab environment.

If you are a CloudBees customer, partner, or employee taking this course you have access to our cloud-based lab environments. SKIP this lesson and follow the instructions in the next lesson Provision lab environment.
Local VM: Vagrant + Virtualbox
A Virtual Machine (VM) is used for hosting your Lab Environment:

It does not break any local environment

It does not depend on the host operating system you are using

It is portable with the same behavior for everyone

This VM runs using the VirtualBox hypervisor, and is managed and automated by Vagrant (see requirements below).

Both of those tools are Open Source, free and multi-platforms, but they require:

Having admin rights on your computer for installation only

Your computer must not already be a Virtual Machine; nested virtualization is not supported.

Common requirements
An HTML5 compliant web browser is required: Mozilla Firefox, Google Chrome, Microsoft Edge, Apple Safari, or Opera.

Internet Explorer is not supported.
The following ports must be allowed access to your instance’s domain:

5000

5001

5002

5003

20000

30001

30002

The following protocols must be allowed by any antivirus/firewall software:

HTTP

HTTPS

Websockets

Some antivirus software like Kasperky and McAfee might block websocket silently.

You can test websockets from WebSockets Test.

For more about security and websockets visit Testing WebSockets.

Even if the training lab is running in offline mode, an open Internet access is recommended. HTTP Proxy can only be configured for Jenkins operations.

Hardware requirements
Your machine must meet the following hardware requirements:

Intel 64 Bits Dual-Core CPU compliant (Intel Pentium/i3 at least)

6GB of RAM (the VM will allocate 4GB for itself)

20GB of free space on your local hard drive

One operating system from this list:

Windows >= 8.1

MacOS >= 10.10

Linux "classic" distribution (Ubuntu >= 12.04, Debian >= Jessie, RHEL>= 6)

The "Virtualization instructions" of your CPU must be enabled (Intel VT-x or AMD SVM)

More information here: https://forums.virtualbox.org/viewtopic.php?f=6&t=58820

Intel official VT page: http://www.intel.com/content/www/us/en/virtualization/virtualization-technology/intel-virtualization-technology.html

Software requirements
Your machine must meet the following software requirements:

For All operating systems, download and install the latest (64 Bits) versions of:

VirtualBox (An Open Source Hypervisor from Oracle):

Downloads page: https://www.virtualbox.org/wiki/Downloads

Make sure to download the appropriate binary for your operating system

We encourage you to download the latest available version of VirtualBox. However, it is worth noting that the last version we tested with this courseware was 6.0.12. So, if you run into trouble with the latest version, please try using this one.

Windows users:

If you have HyperV installed, VirtualBox may throw some errors with the code VERR_VMX_NO_VMX.

In this case (Stack Overflow - Vagrant up - VBoxManage.exe error: VT-x is not available (VERR_VMX_NO_VMX)), please disable HyperV temporarily : (Disable HyperV)

bcdedit /set hypervisorlaunchtype off
and reboot

Vagrant (An Open Source VM manager):

Downloads page: https://www.vagrantup.com/downloads.html

Make sure to download the appropriate binary for your operating system

We encourage you to download the latest available version of Vagrant. However, it is worth noting that the last version we tested with this courseware was 2.2.5. So, if you run into trouble with the latest version, please try using this one.

For Windows only, download latest version of Git for Windows

Git for Windows provides a bash-compliant shell and OpenSSH client
Getting lab resources
After installing the software prerequisites:

Right click this link to the virtual machine’s ZIP archive to open it in a new tab or window. When you click OK, the archive downloads to your local disc.

Extract the virtual machine ZIP archive to your local disc. This archive contains your virtual machine image and automated settings in a folder named cloudbees-training-admin-fundamentals.

Starting the lab environment
Open a command line on your host operating system:

On MacOS, open Applications , Utilities , Terminal

On Windows, open Start Menu , Git Bash

On Linux, this can be named Command Line or Terminal

The command line is required to start the Virtual Machine without having to care to any specific configuration.
Using the command line cd, navigate to the un-archived folder that should be located on your Desktop:

cd ~/Desktop/cloudbees-training-pipeline-fundamentals/
The ~ special character means "Full path to the user home folder"

Desktop may vary depending on your operating system; it can be lower case, or localized in your operating system’s language.

Use the command line ls to check the content of this directory. We need to have a file named Vagrantfile here:

ls -1
  Vagrantfile
Now you are able to start the Virtual Machine, using the vagrant command:

vagrant up
The VM should start without a GUI, and without any error:

If some warnings about VirtualBox version appear, ignore them as long as everything is working well.
lab vagrant up log
Figure 1. Vagrant starting the VM for you
You must be able to stop and start the Virtual Machine whenever you want. Let’s do it now:

From the cloudbees-training-pipeline-fundamentals folder that contains a Vagrantfile:

Stop the VM "gracefully" with the vagrant "halt" command:

vagrant halt
Once the VM is in the stopped state, you can safely do anything else, like stopping your computer
Restart the Virtual Machine:

vagrant up
Any Vagrant command can be used here. For more informations, please check Vagrant Documentation - https://www.vagrantup.com/docs/cli/

Accessing the lab environment
Your Lab Environment provides a Home Page to use as the entry point. This page is available on your web browser when you open your lab instance.

Unless specified differently, any authentication asked by any service in the Lab Environment uses the following:

Username: butler

Password: butler

You will see an HTML page that lists the services hosted on your Lab Environment.

Each service is detailed in the next steps.

Troubleshooting
If you face any issue with the lab during this course, please read this troubleshooting guide first.

If you still cannot use the lab environment, depending on your training type:

"Trainer led": please ask your trainer for help.

"Self Paced": please open a ticket by following the instructions found in the "Open a training ticket" at the start of the course.

Always double-check your settings: peer review is the best!
Technical troubleshooting
If an error was raised during the initial VM startup:

If the error is related to GuestAdditions like the one below:

==> default: Machine booted and ready!
[default] GuestAdditions versions on your host (5.1.8) and guest (5.0.18_Ubuntu r106667) do not match.
...
The following SSH command responded with a non-zero exit status.
Vagrant assumes that this means the command failed!

apt-get update
...
Then remove the plugin vagrant-vbguest, by using the command

vagrant plugin uninstall vagrant-vbguest
If the error is related to VT-x is not available

...
Stderr: VBoxManage.exe: error: VT-x is not available (VERR_VMX_NO_VMX)
Make sure you disable the HyperV service as stated in the 'Software Requirements' of this document.

Is your VM started?

Open VirtualBox GUI and check the state.

With you command line, use vagrant status within your labs directory.

On your process manager, verify that you have a VBoxHeadless process.

Is your VM reachable with SSH ?

Is Vagrant aware of port forwarding (using vagrant port) ?

In the VirtualBox GUI, do you see the port forwarding ?

Do you have any firewall rule that would block any traffic on your localhost (l0, loopback, etc.) interface, on the forwarded port (2222 generally)?

When stuck, always try rebooting the VM one time.

If you need to submit an issue (self-paced training only), try to run your latest vagrant command in debug mode (see example below ), and copy-paste the result in a text file or in https://gist.github.com/.

VAGRANT_LOG=debug vagrant up
