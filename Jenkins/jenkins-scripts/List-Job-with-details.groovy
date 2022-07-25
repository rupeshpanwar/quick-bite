- https://javadoc.jenkins.io/hudson/model/Item.html?is-external=true#BUILD

println " JobName "+ " JobType " + " LastBuild " + "  EstimatedDurationtion " + " All DownStreamJobs "
Jenkins.instance.getAllItems(Job.class).each{
    println  it.fullName +  it.class  +  it.getLastBuild()  +  it.getEstimatedDuration() + it.getAllJobs()
}




# jobs with failed reason
Jenkins.instance.getAllItems(Job.class).each{
allItems = it.getAllJobs()

 allItems.each{
    println  it.fullName +  it.class  +  it.getLastBuild()  +  it.getEstimatedDuration() + it.getAllJobs()
}

  activeJobs = allItems.findAll{
    job -> job.isBuildable()
    }


failedRuns = activeJobs.findAll{job -> job.lastBuild.result == hudson.model.Result.FAILURE}
  
  failedRuns.each{ item ->
    println("=====================================================================")
    println "Failed Job Name: ${item.name}"
    item.lastBuild.getLog().eachLine { line ->
          println "error: $line"
    }
}

}