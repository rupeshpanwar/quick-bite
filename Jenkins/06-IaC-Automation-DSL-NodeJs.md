# IaC Introduction
<img width="566" alt="image" src="https://user-images.githubusercontent.com/75510135/130236803-43e5a588-d4cf-45a3-b443-79b4b7a3ac1b.png">
<img width="958" alt="image" src="https://user-images.githubusercontent.com/75510135/130236964-729efcdb-e0ac-41e6-90cf-df20dbeca52d.png">
<img width="952" alt="image" src="https://user-images.githubusercontent.com/75510135/130237123-f29ec38b-28b6-4903-aed3-45430de68d48.png">
<img width="947" alt="image" src="https://user-images.githubusercontent.com/75510135/130237321-57e33b29-5224-463a-b649-48fd7c174c83.png">


# Jenkins Job DSL with NodeJS application
- here is the groovy script used
```
job('NodeJS example') {
    scm {
        git('git://github.com/rupeshpanwar/docker-demo.git') {  node -> // is hudson.plugins.git.GitSCM
            node / gitConfigName('DSL User')
            node / gitConfigEmail('rupeshpanwar28@gmail.com')
        }
    }
    triggers {
        scm('H/5 * * * *')
    }
    wrappers {
        nodejs('nodejs') // this is the name of the NodeJS installation in 
                         // Manage Jenkins -> Configure Tools -> NodeJS Installations -> Name
    }
    steps {
        shell("npm install")
    }
}
```
<img width="773" alt="image" src="https://user-images.githubusercontent.com/75510135/130237639-101ba04b-5ace-4b4e-8166-c9814ac14334.png">

<img width="828" alt="image" src="https://user-images.githubusercontent.com/75510135/130237577-d6b16553-c3b7-4504-8125-c7bdfc76248b.png">

<img width="821" alt="image" src="https://user-images.githubusercontent.com/75510135/130237757-7e6c4fa3-711e-4b74-8b3b-a612fe132ac9.png">
- install Job DSL pulgin
<img width="1057" alt="image" src="https://user-images.githubusercontent.com/75510135/130238368-2c36e5c8-e607-4ccf-82bb-4b7654fa380b.png">
- create Freestyle project
<img width="1068" alt="image" src="https://user-images.githubusercontent.com/75510135/130239796-a4e05fe7-742c-4fa7-b251-48fbdab673a7.png">
- https://github.com/rupeshpanwar/jenkins-course
<img width="935" alt="image" src="https://user-images.githubusercontent.com/75510135/130242045-d5d52598-dc75-406d-88d9-a85fb0adfbef.png">
<img width="817" alt="image" src="https://user-images.githubusercontent.com/75510135/130242604-fc677cae-d94e-4997-89e2-bbe5cd0b77ef.png">

- need to approve the script first
![image](https://user-images.githubusercontent.com/89126068/130305613-fd91bbbc-6b22-4145-b80d-85530163f740.png)
- under Manage Jenkins, click on In-process script approval
![image](https://user-images.githubusercontent.com/89126068/130305740-48f1fbc4-7887-4096-8a32-363306fa50fc.png)
![image](https://user-images.githubusercontent.com/89126068/130305744-7b0922f0-c2f9-401b-947c-8e29f8f97771.png)
- click on Build now again
![image](https://user-images.githubusercontent.com/89126068/130305782-f675e9d1-fe64-47bd-9e72-16b90a9b84d2.png)
![image](https://user-images.githubusercontent.com/89126068/130305794-d6f28b06-44bc-4edb-b53a-af9c31e9c305.png)
![image](https://user-images.githubusercontent.com/89126068/130305798-5cdd5a1a-f040-41ee-af45-6fffed3dd02c.png)


- behind the scene, job was configured for NodeJs example
![image](https://user-images.githubusercontent.com/89126068/130305854-3cfd06ec-780c-47d8-a2b6-6c96895bdf41.png)
![image](https://user-images.githubusercontent.com/89126068/130305866-0993e236-4826-4cfa-8c77-e243f07e469f.png)
![image](https://user-images.githubusercontent.com/89126068/130305872-09c752c4-7257-45ea-9199-661c52359211.png)
![image](https://user-images.githubusercontent.com/89126068/130305875-3b35ad9d-0c89-44b7-93ee-6e991de4e034.png)
- click on NodeJs example then click on  build now, (#4)
![image](https://user-images.githubusercontent.com/89126068/130305897-43d4e7ba-95b0-46e2-9947-d558e51423a2.png)
![image](https://user-images.githubusercontent.com/89126068/130305902-6a75b3b1-1599-4fd9-8a6e-3f982b77cbf2.png)
![image](https://user-images.githubusercontent.com/89126068/130305906-8ccebbec-ec42-4183-aac8-43b9a61849b6.png)
- login into jenkins container, then search for nodejs installation path to kick of npm start
![image](https://user-images.githubusercontent.com/89126068/130306180-74dca17a-2ab5-4432-8b3d-399e3bd3a3da.png)







