jenkins.model.Jenkins.instance?.getAllItems(com.cloudbees.hudson.plugins.folder.Folder).each { folder ->
  println "Folder - ${folder}"
  folder.getItems().each {
    println "\t job - ${it}"
  } 
}


OR



import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*

import hudson.scm.*
import hudson.tasks.*
import com.cloudbees.hudson.plugins.folder.*


jen = Jenkins.instance

jen.getItems().each{
    if(it instanceof Folder){
        processFolder(it)
    }else{
        processJob(it)
    }
}

void processJob(Item job){

}

void processFolder(Item folder){
    folder.getItems().each{
        if(it instanceof Folder){
            processFolder(it)
        }else{
            processJob(it)
        }
    }
}