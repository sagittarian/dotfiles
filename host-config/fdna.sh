# fdna
alias alc='workon alc && cd algo_code'
alias rungw='gunicorn -b 0.0.0.0:9000 --log-file=- --access-logfile=- --error-logfile=- greenwood.greenwood:app'

alias agentify='eval $(ssh-agent) && ssh-add ~/.ssh/id_rsa_fdna'

function pypath {
    echo PYTHONPATH=/home/adam/src/common_infra/$1:/home/adam/src/searcher/$1
}

# greenwood
export FLASK_DEBUG=1
export FLASK_APP=/home/adam/src/greenwood/greenwood/greenwood.py

