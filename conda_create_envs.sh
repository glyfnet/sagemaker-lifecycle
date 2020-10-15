#!/bin/bash

$CONDA_DIR/bin/activate
RESTART_JUPYTER=false
for path in $WORKING_DIR/*; do
    if [ -d "$path" ]; then
        if [[ $path != *"."* ]]; then
            project=$(base_name $path)
            envfile=$path/environment.yml
            envdir=$CONDA_PATH/env/$project
            reqsfile=$project/requirements.txt
            
            if [ -f "$envfile" ]; then
                if [ -d "$envdir" ]; then
                    echo "Updating conda project $project with $envfile"
                    conda env update --prefix $envdir -f $envfile --prune
                else
                    echo "Creating conda project $project for $envfile"
                    conda env create -f $envfile
                    RESTART_JUPYTER=true
                fi
            else
                echo "Creating conda project $project"
                conda create -q -v --name $project python=3.8
                RESTART_JUPYTER=true
            fi
            
            if [ "$RESTART_JUPYTER" = true ]; then
                echo "Adding ipykernal to $project"
                python -m ipykernel install --user --name "$project" --display-name "project $project"
            fi
            
            if [ -f "$reqsfile" ]; then
                echo "Adding requirements to $project from $reqsfile"
                pip -r $reqsfile
            fi
        fi
    fi
done

export RESTART_JUPYTER