cd .devops
#terraform init
#terraform apply
#terraform output -json > ../fargate-mulesoft-hello-world/output.json

cd ..
cd fargate-mulesoft-hello-world

HTTPS_REPO_URL=$(jq -r '.codecommit_repo.value' output.json)
echo $HTTPS_REPO_URL

git init
git remote add origin $HTTPS_REPO_URL
git add .
git commit -m "First commit"
git push -u origin master

echo -e "protocol=https\npath=/v1/repos/fargate-mulesoft-hello-world\nhost=git-codecommit.ap-southeast-2.amazonaws.com" | aws codecommit credential-helper get 

git config credential.helper '!aws codecommit credential-helper $@'
git config credential.UseHttpPath true