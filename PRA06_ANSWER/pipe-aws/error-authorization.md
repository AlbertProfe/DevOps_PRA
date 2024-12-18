### Error authorization


1. The **`devops`** user does not have permission to perform the `ecr-public:GetAuthorizationToken` operation on Amazon ECR.

**Verify that the policies are correctly applied**:

- **AmazonEC2ContainerRegistryFullAccess**: This policy allows the user to access both public and private ECR repositories.
- **AmazonECRPublicFullAccess**: This policy is required to specifically access public ECR repositories.
- **Access the IAM console:**

  - Log in to the AWS console.
  - Go to IAM (Identity and Access Management).

  **Select the devops user:**

  - In the left panel, select Users, then click on the devops user.

  **Attach the AmazonECRPublicFullAccess policy:**

  - Click on the Permissions tab.
  - In the top-right corner, click on Add permissions.
  - Select Attach existing policies directly.
  - Search for the AmazonECRPublicFullAccess policy in the list and check the box next to it.
  - Click Review and then click Add permissions.


    <img title="" src="file:///home/albert/Desktop/pipelines/aws-pra06/aws-deploy/pipeline-push-ecr-ok.png" alt="pipeline-push-ecr-ok.png" width="613">
