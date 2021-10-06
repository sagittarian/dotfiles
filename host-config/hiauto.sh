eval "$(sed -e 's/^/export /' -e 's/=\(.*\)$/="\1"/' $HOME/dev/nlu_pipeline/devops/local/.env)"
alias build-dt="docker build -t drive-thru-backend:local --build-arg DATA_COLLECTION_CONNECTION_STRING='$DATA_COLLECTION_CONNECTION_STRING' ."
export NLU_REPO=$HOME/dev/nlu_pipeline
alias run-dt="docker run -ti -p 8080 -v $NLU_REPO:/nlu_pipeline -v ~/secrets:/secrets --env-file $NLU_REPO/devops/local/.env drive-thru-backend:local /bin/bash"
alias dt-run="docker run -ti -p 8080 -v $NLU_REPO:/nlu_pipeline -v ~/secrets:/secrets --env-file $NLU_REPO/devops/local/.env drive-thru-backend:local"
alias compose-dt="docker-compose build --build-arg DATA_COLLECTION_CONNECTION_STRING='$DATA_COLLECTION_CONNECTION_STRING'"

HIAUTO_UUID=adamraizen

export PULSE_SERVER=172.17.0.1
export REACT_APP_NODE_ENV=development
alias pulseaudio-tcp='pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1'
alias run-cl="BULLET_TRAIN_KEY=e2WvbMSubLJrdBV8beotw7 python3 drivethru_client/drivethru_client.py --backend-url http://localhost:8080 --input-device-prefix pulse --uuid $HIAUTO_UUID --brand lees --output-device pulse"


export PYTHONPATH=$HOME/dev/nlu_pipeline:$PYTHONPATH
