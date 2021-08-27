https://github.com/aws-samples/aws-codeguru-profiler-demo-application

<img width="1239" alt="image" src="https://user-images.githubusercontent.com/75510135/131071727-67fda259-38fe-43be-ae77-94500bf36cce.png">
<img width="498" alt="image" src="https://user-images.githubusercontent.com/75510135/131071797-1cb363e9-b8b4-4f4d-99c5-17574a63ebde.png">
<img width="514" alt="image" src="https://user-images.githubusercontent.com/75510135/131071814-e295423f-1260-43a7-8ff9-6d6e0d8a1818.png">
<img width="1052" alt="image" src="https://user-images.githubusercontent.com/75510135/131071857-53a25fa9-5a53-4f26-9577-6c70221ef277.png">
<img width="1425" alt="image" src="https://user-images.githubusercontent.com/75510135/131071919-fc8813e9-8d64-489d-9aa9-a5684dc13d84.png">
<img width="1354" alt="image" src="https://user-images.githubusercontent.com/75510135/131072338-1eb0f2a3-2d5c-4112-8a57-ec65d55f0c67.png">
java -javaagent:codeguru-profiler-java-agent-standalone-1.2.1.jar="profilingGroupName:codeguruprofiler-dev,heapSummaryEnabled:true" 
<img width="906" alt="image" src="https://user-images.githubusercontent.com/75510135/131072430-d4db1013-fada-4695-8e99-25d813d82812.png">
import software.amazon.codeguruprofilerjavaagent.Profiler
new Profiler.Builder()
  .profilingGroupName("codeguruprofiler-dev")
  .withHeapSummary(true) // optional - to start without heap profiling set to false or remove line
  .build()
  .start()
  
  <img width="1074" alt="image" src="https://user-images.githubusercontent.com/75510135/131072478-4d9fa6f6-6d0a-49a4-8c69-7f8ba9b28d29.png">

<img width="1391" alt="image" src="https://user-images.githubusercontent.com/75510135/131072669-a2328aa7-bb83-44a0-b366-1f50fe1a1f44.png">
<img width="1088" alt="image" src="https://user-images.githubusercontent.com/75510135/131072694-66d713b9-5abc-40ef-bd54-8711d146437c.png">
