pipeline {

    agent any
    
    stages {
    	
        stage('Lint HTML') {
	        steps {
                sh 'tidy -q -e *.html'
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
	    
	    stage('Deploy app') {
	    	steps {
	    		withAWS(region:'us-west-2',credentials:'Capstone') {
	    			sh 'kubectl apply -f https://raw.githubusercontent.com/aberdean/devops-capstone-project/master/deploment.yaml'
	    		}
	    	}
	    }
    }
}
