<img width="414" alt="image" src="https://user-images.githubusercontent.com/75510135/131530769-9109d244-9b80-4e79-8247-5a1441cfd29e.png">
<img width="534" alt="image" src="https://user-images.githubusercontent.com/75510135/131531399-7def58de-b359-498a-aff6-752e19dd053d.png">
<img width="551" alt="image" src="https://user-images.githubusercontent.com/75510135/131531435-b571d2f0-19ed-4301-bae9-4ad920a63da6.png">
- dashboard for survey
```
import React from 'react';
import { Link } from 'react-router-dom';

const Dashboard = () => {
  return (
    <div>
      Dashboard
      <div className="fixed-action-btn">
        <Link to="/surveys/new" className="btn-floating btn-large red">
          <i className="material-icons">add</i>
        </Link>
      </div>
    </div>
  );
};

export default Dashboard;

```
