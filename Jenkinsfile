pipeline {

    agent any
    
    stages {
    
        stage('Install tidy') {
            steps {
                sh '''
                    sudo apt-get update &&\
                    sudo apt-get install -y tidy
                '''
            }
        }
    
        stage('Lint HTML') {
	        steps {
                sh 'tidy -q -e *.html'
	        }    
	    }
	    
	    stage('Install hadolint') {
	        steps {
    	        sh '''
    	            sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
                    sudo chmod +x /bin/hadolint
    	        '''
    	    }
	    }
	    
	    stage('Lint Dockerfile') {
	        steps {
	            sh 'hadolint Dockerfile'
	        }
	    }
	    
	    stage('Build Docker image') {
	        steps {
	            sh 'docker build --tag=capstoneimage .'
	        }
	    }
	    
	    stage('Upload Docker image to Docker Hub') {
	        steps {
	            withDockerRegistry([url: '', credentialsId: 'dockerhub']) {
	                sh '''
    	                docker tag capstoneimage aberdean/capstone &&\
    	                docker push aberdean/capstone
    	            '''
	            }
	        }
	    }
    }
    
}
