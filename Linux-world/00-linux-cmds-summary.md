<img width="942" alt="image" src="https://user-images.githubusercontent.com/75510135/150976365-1d0adf9b-2037-46ee-a5cb-cd1a5a7309f5.png">

<img width="941" alt="image" src="https://user-images.githubusercontent.com/75510135/150976294-5fc9210f-40f6-4154-9ef2-ff07178096db.png">
<img width="932" alt="image" src="https://user-images.githubusercontent.com/75510135/150976444-b835d389-9810-4656-9bba-b02f69612922.png">

```

vi Commands 

i - Insert at cursor (goes into insert mode)
a - Write after cursor (goes into insert mode)
A - Write at the end of line (goes into insert mode)
ESC - Terminate insert mode
u - Undo last change
U - Undo all changes to the entire line
o - Open a new line (goes into insert mode)
dd - Delete line
3dd - Delete 3 lines.
D - Delete contents of line after the cursor
C - Delete contents of a line after the cursor and insert new text. Press ESC key to end insertion.
dw - Delete word
4dw - Delete 4 words
cw - Change word
x - Delete character at the cursor
r - Replace character
R - Overwrite characters from cursor onward
s - Substitute one character under cursor continue to insert
S - Substitute entire line and begin to insert at the beginning of the line
~ - Change case of individual character

Moving within a file

k - Move cursor up
j - Move cursor down
h - Move cursor left
l - Move cursor right

Saving and Closing the file

Shift+zz - Save the file and quit
:w - Save the file but keep it open
:q - Quit without saving
:wq - Save the file and quit
<img width="457" alt="image" src="https://user-images.githubusercontent.com/75510135/145764364-1cf20f81-a381-4caf-8003-6abc64c503a4.png">
- keep the jenkins auto start
```

```
$ cat /etc/passwd => to view users
- to create paasword for a user
$ paaswd username
$ id => to view the user/group information
$ cat /etc/group => to view groups
=> to change user group
<img width="545" alt="image" src="https://user-images.githubusercontent.com/75510135/151080915-bb2a13e2-00a3-463f-ac72-a5a1698718d6.png">

- to login as a user called session based authentication , modify /etc/ssh/sshd_config
$ vi /etc/ssh/sshd_config
- mark YES for PasswordAuthentication in above file
PasswordAuthentication yes
- now reload the sshd service
$ service sshd reload

- hidden file (.)
$ ls -la

- file/directory type
$ file filenme or directoryname


- Add the service to boot process
$ sudo chkconfig jenkins on
```
<img width="690" alt="image" src="https://user-images.githubusercontent.com/75510135/151081529-27f17c7c-b83f-4783-82e0-f72ed788f428.png">


<img width="932" alt="image" src="https://user-images.githubusercontent.com/75510135/150980273-e040b4b2-231e-49d6-b9dd-a93dfe40a954.png">
<img width="1049" alt="image" src="https://user-images.githubusercontent.com/75510135/150981940-b21579c4-0c8d-47b5-96a6-b2bbeba2e973.png">
<img width="1016" alt="image" src="https://user-images.githubusercontent.com/75510135/150982506-2d724c82-a614-4157-acfc-c11cd453e907.png">
<img width="1023" alt="image" src="https://user-images.githubusercontent.com/75510135/150983602-578aaa5c-3e0d-4075-ba09-e56064c5c9ca.png">
<img width="968" alt="image" src="https://user-images.githubusercontent.com/75510135/151079839-844d3521-86f8-4e41-a43c-656aba33fc79.png">
<img width="816" alt="image" src="https://user-images.githubusercontent.com/75510135/151080559-9b73f333-0457-4b0a-99ea-bea71cfbf415.png">
<img width="492" alt="image" src="https://user-images.githubusercontent.com/75510135/151080585-dad47b61-bc8d-4f99-93f1-01102cabe8d6.png">
<img width="501" alt="image" src="https://user-images.githubusercontent.com/75510135/151081799-97d98efa-bcb3-433c-af90-a1b77ffabb68.png">
<img width="887" alt="image" src="https://user-images.githubusercontent.com/75510135/151081946-c9d1ad9c-7f54-4e53-9a81-fecebc210258.png">
<img width="924" alt="image" src="https://user-images.githubusercontent.com/75510135/151081966-859c8db4-5d01-4102-8a31-4bdeaf407d76.png">
<img width="843" alt="image" src="https://user-images.githubusercontent.com/75510135/151082144-410290fa-3263-4925-ae82-080f85020256.png">
<img width="1034" alt="image" src="https://user-images.githubusercontent.com/75510135/151082725-a742aa3f-0558-4910-aa66-bd4091dc9223.png">
<img width="917" alt="image" src="https://user-images.githubusercontent.com/75510135/151082784-c89cc767-5d6c-4f80-99bd-4f9c70b263d9.png">
```
- to display permission of a Directory
$ ls -ld directory-name

- OS version
cat /etc/redhat-release


```
<img width="574" alt="image" src="https://user-images.githubusercontent.com/75510135/151082962-bf462006-18e4-44a3-a189-1641cc20f1c7.png">
<img width="1004" alt="image" src="https://user-images.githubusercontent.com/75510135/151083088-70a6499a-2712-4ce3-8c9d-d5a50c25cbf0.png">
<img width="567" alt="image" src="https://user-images.githubusercontent.com/75510135/151083334-59910239-c974-4c58-9bf6-4611781bec3b.png">
<img width="516" alt="image" src="https://user-images.githubusercontent.com/75510135/151083542-c359f987-f4db-4621-b596-04c342d97faf.png">
* change ownership for file/directory
<img width="694" alt="image" src="https://user-images.githubusercontent.com/75510135/151084376-ce3cd91d-b69f-4fce-8ee3-9b2cedc4740f.png">
<img width="677" alt="image" src="https://user-images.githubusercontent.com/75510135/151084580-549c6ede-3454-4e5b-a442-5fe93fbf0b8d.png">



<img width="939" alt="image" src="https://user-images.githubusercontent.com/75510135/151084740-e7e69d32-a995-48d8-8f47-3a7dcaf2453e.png">
<img width="756" alt="image" src="https://user-images.githubusercontent.com/75510135/151085098-7841eece-34d7-4973-98e6-ad7125ea8bdd.png">
<img width="641" alt="image" src="https://user-images.githubusercontent.com/75510135/151085131-090b4045-3e38-4b30-ac26-e8b19c871af2.png">
<img width="589" alt="image" src="https://user-images.githubusercontent.com/75510135/151085158-a86a993f-92e4-4c04-92f2-72e9681fcd6f.png">
<img width="1068" alt="image" src="https://user-images.githubusercontent.com/75510135/151085199-c07b8091-9021-4954-8e0e-ce1196b94f9f.png">
<img width="584" alt="image" src="https://user-images.githubusercontent.com/75510135/151085587-c5511912-6f93-4207-bc18-cc15b36a39ff.png">
<img width="518" alt="image" src="https://user-images.githubusercontent.com/75510135/151085701-e06f198f-8144-48b9-868c-b20a8faeb391.png">
<img width="652" alt="image" src="https://user-images.githubusercontent.com/75510135/151085714-4de846ca-acd7-46e0-a074-2e7e7178b932.png">


<img width="1047" alt="image" src="https://user-images.githubusercontent.com/75510135/151085808-dd371f8b-1923-4bda-9946-bf06f97267b4.png">
```
- check if package is installed or not
$ yum list installed | grep package-name

- check if package is available or not
$ yum list available | grep package-name
```

<img width="935" alt="image" src="https://user-images.githubusercontent.com/75510135/151087355-e557ba5b-cbe5-43ce-af46-0bc8a8b37010.png">

```
- find the machine name 
$ cat /etc/hostname

- change the hostname
$ hostname machine-new-name

- to restart the machine
init 6
```
<img width="672" alt="image" src="https://user-images.githubusercontent.com/75510135/151101929-fabd0d4b-77c8-41e0-b994-816480857968.png">
<img width="893" alt="image" src="https://user-images.githubusercontent.com/75510135/151101989-a2273953-0f5e-450f-98b6-0284a6f40eb2.png">
<img width="838" alt="image" src="https://user-images.githubusercontent.com/75510135/151102288-a58ea51c-43b8-4c48-8e49-af7df1fc6052.png">
<img width="1023" alt="image" src="https://user-images.githubusercontent.com/75510135/151102748-8bfce104-766a-47f5-93c7-da27a37600ad.png">
<img width="659" alt="image" src="https://user-images.githubusercontent.com/75510135/151102806-b419f9b0-6340-4298-b4f2-2b31dd9373a3.png">

<img width="1012" alt="image" src="https://user-images.githubusercontent.com/75510135/151103576-26f3b0ed-e889-4b15-a816-e2c6868e4768.png">
<img width="925" alt="image" src="https://user-images.githubusercontent.com/75510135/151104245-f2a8fe14-2620-4ac8-a97e-d93dd9a380d1.png">
<img width="703" alt="image" src="https://user-images.githubusercontent.com/75510135/151104571-d213421c-708a-4e08-a3a7-a3f1008b6d71.png">
<img width="1009" alt="image" src="https://user-images.githubusercontent.com/75510135/151104802-edeb5480-682e-4285-8dad-1f2139788be3.png">
<img width="546" alt="image" src="https://user-images.githubusercontent.com/75510135/151104902-75dd5748-4505-4381-9d47-9fd314174267.png">
<img width="779" alt="image" src="https://user-images.githubusercontent.com/75510135/151105421-4b37c658-df30-48b9-8c5f-069539fcb22e.png">
<img width="959" alt="image" src="https://user-images.githubusercontent.com/75510135/151106038-375cde71-a476-40f2-a6fe-e88647ef9b45.png">


