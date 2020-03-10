#!/bin/bash

echo  "";

read -p 'Nombre/Ruta del proyecto a crear: ' route;
echo  "";

if [ "$route" ];
  then  
    read -p 'Dependencias: ' dependencies;
    echo  "";
    read -p 'Dependencias de desarrollo: ' devDependencies;
    echo  "";
    read -p 'Componentes: ' components;
    echo "";
    read -p "Abrir vscode y correr el proyecto react (Si/No)? " choice;

    create-react-app $route;

    cd $route/src;
    mkdir -p components/App assets constants;

    mv App.css components/App/index.css;
    #remplazo la ruta de App.css por el nuevo nombre
    sed -i 's/\/App.css/\/index.css/g' App.js
    cat App.js  | grep -v "logo" > components/App/index.js;
    
    sed -i 's/\/App/\/components\/App/g' index.js;
    #lo guardo en un archivo temporal porque si no no se puede hacer
    head -n 8 index.js | grep -v "serviceWorker" > indexTmp;
    mv indexTmp index.js;
    rm logo* App* se*.js;
    
  else 
    echo "Debe ingresar el nombre del proyecto del proyecto";
fi

#depencencies
if [[ ${dependencies} != '' ]]; 
  then  
    for i in ${dependencies[@]}
      do
      npm install $i  
    done
fi

#devDepencencies
if [[ ${devDependencies} != '' ]]; 
  then  
    for i in ${devDependencies[@]}
      do
       npm install --save-dev $i;
    done
fi

#COMPONENTS
if [[ ${components} != '' ]]; 
  then  
    for i in ${components[@]}
      do
       mkdir -p components/$i;
       touch components/$i/index.{js,module.scss};
       echo "import React from 'react'; " > components/$i/index.js;
    done
fi



case "$choice" in
  Si|si|sI|SI ) 
        cd ../; 
        code .; 
        npm start ;;
  * ) echo "" ;;
esac
