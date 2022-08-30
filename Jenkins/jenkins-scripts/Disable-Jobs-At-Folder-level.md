```
import hudson.model.*
 
disableChildren(Hudson.instance.items)
 
def disableChildren(items) {
  for (item in items) {
    if (item.class.canonicalName == 'com.cloudbees.hudson.plugins.folder.Folder') {
       
      if( ((com.cloudbees.hudson.plugins.folder.Folder) item).getItems().toString().contains('<Folder-name>') ){
       
        disableChildren(((com.cloudbees.hudson.plugins.folder.Folder) item).getItems())
   
      }
    } else if (item.class.canonicalName != 'org.jenkinsci.plugins.workflow.job.WorkflowJob') {
      item.disabled=true
      item.save()
      println("job is disabled => " + item.name)
    }
  }
}
```


```
Example that does not traverse child folders:

import com.cloudbees.hudson.plugins.folder.AbstractFolder

folderName="folder-a" // change value `folder-a` for the full name of the folder you want to disable all jobs in

Jenkins.instance.getItemByFullName(folderName, AbstractFolder).getItems()
    .findAll { it instanceof ParameterizedJobMixIn.ParameterizedJob || it instanceof AbstractFolder }
    .each {
        it.makeDisabled(true)
        println("Disabled job: [$it.fullName]")
    }
null
Example that does traverse child folders:

import com.cloudbees.hudson.plugins.folder.AbstractFolder

folderName="folder-a" // change value `folder-a` for the full name of the folder you want to disable all jobs in

Jenkins.instance.getItemByFullName(folderName, AbstractFolder).getAllItems()
    .findAll { it instanceof ParameterizedJobMixIn.ParameterizedJob || it instanceof AbstractFolder }
    .each {
        it.makeDisabled(true)
        println("Disabled job: [$it.fullName]")
    }
null
You can perform a dry run by commenting out the disable line, i,e:

      //it.makeDisabled(true)
```
