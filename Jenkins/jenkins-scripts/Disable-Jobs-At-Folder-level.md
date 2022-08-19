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
