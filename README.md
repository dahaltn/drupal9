##Welcome to Drupal 9 Commerce Project
This is an amazing project developed by Tej Dahal (dahaltn@gmail.com) to build a drupal based product

### Project setup in local environment
- Download the repo
- Run docker-compose up -d (make sure docker installed)
- Run composer install
- Copy the project Root /src/sites/default/settings.php into the drupal/web/sites/default
- Run composer install-drupal from the web container
- once completed check in the browser http://localhost


### Setting up Continuous deployment using Github actions
- Create a simple workflow in github which triggers on push to branches
- Go to github setting for the project and add self-hosted runner in Actions
- Add a self-hosted runner and follow the instructions
- In the docker host create a user (adduser username) and give sudo permission (usermod -aG sudo username )
- Add the user to docker group (usermod -aG docker username) and switch to the user
 
