# Select the source, branch, then Select a template - Node.js with Grunt
![image](https://user-images.githubusercontent.com/75510135/126268651-c874249b-f1c9-4f4e-9039-419cc8f7bcd7.png)

- Rename the pipeline
![image](https://user-images.githubusercontent.com/75510135/126268576-a7a1b822-4c3b-43e9-b595-228152b63a00.png)

- Remove 2nd step under Agent tasks - Run Grunt task
![image](https://user-images.githubusercontent.com/75510135/126268485-44477e08-2953-49e8-a5e4-bb87ad3f707c.png)

- Under 1st step , NPM install, pickup the working dir where PACKAGE.json is listed
![image](https://user-images.githubusercontent.com/75510135/126268128-582bdae2-993e-492e-ad3f-2d405d367bee.png)

- Now Clone NPM install task, rename it , choose custom under command section , type , run build under command and arguments
![image](https://user-images.githubusercontent.com/75510135/126268026-489d39ff-94e0-4b6d-93a3-fb6b60ce7e0b.png)


- Next step, Archieve , select the path , root folder/dist/project [this path is generated when we execute, npm run build]
![image](https://user-images.githubusercontent.com/75510135/126267908-c16388b2-51c5-4eaa-8392-16e28fd3318d.png)

- Publish Artifacts, keep as it is

![image](https://user-images.githubusercontent.com/75510135/126267777-3a5d9760-5ca5-42a4-b85d-07852fdafa00.png)

- Run the CI Pipeline

![image](https://user-images.githubusercontent.com/75510135/126268903-57dd5656-73cd-4565-b7e0-ef72fd3e61d1.png)

![image](https://user-images.githubusercontent.com/75510135/126268931-329782b3-57c1-49c5-802b-eff392f9995d.png)

# CD - Deploy App to Web App

- Select the template to deploy

- Add Artifact produced by CI pipeline

![image](https://user-images.githubusercontent.com/75510135/126271555-f1f4c0c1-60c9-418e-9799-2efbf5addf55.png)


- Select the respective fields
![image](https://user-images.githubusercontent.com/75510135/126271172-02efdb01-9161-4ad6-b574-afd5e099975f.png)

- Enable CD(continuous deployment

![image](https://user-images.githubusercontent.com/75510135/126271726-73683e8e-a86d-4510-81ad-62fffb8de844.png)


