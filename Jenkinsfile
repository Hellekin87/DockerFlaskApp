node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
        app = docker.build("flask")
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. 
         /*
         https://registry.hub.docker.com
        docker.withRegistry('https://registry-1.docker.io/v2/', 'docker-hub-credentials') {
            //${env.BUILD_NUMBER}
            app.push("mabi/flask")
            //app.push("mabi")
            //app.push("latest")
            //app.push()
        }*/
        docker.withRegistry('https://registry.example.com', 'docker-hub-credentials') {

        def customImage = docker.build("my-image:${env.BUILD_ID}")

        /* Push the container to the custom Registry */
        customImage.push()
    }
    }
}
