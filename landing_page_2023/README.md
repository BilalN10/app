# Documentation

## Connection au projet

il faut que vous soyez connecté au compte google du projet. Pour ce faire:

- Déconnectez vous du compte actuel si ce n'est pas celui du projet

```bash
$ firebase logout
```

- Connectez vous au compte du projet

```bash
$ firebase login
```

## Récuperer le projet

1. faire la commande suivante au root de votre projet :

```bash
$ git clone -----------
```

2. Si les fichiers [.firebaserc](.firebaserc), [firebase.json](firebase.json) sont présent faite la commande suivante :

```bash
$ rm -rf .firebaserc firebase.json .git .gitignore .vscode
```

3. Initialiser votre hosting et dossier cloudFunction avec la commande suivante :

```bash
$ cd landing_page_2023 && firebase init
```

- Sélectionnez [Functions] [Hosting] (le premier hosting dans la list)
- Sélectionnez [Initialize]
- Sélectionnez [TypeScript]

## Configuration

1. Dans le fichier [config](public/config.js)

- `appName`: nom de votre application
- `googleplayURL`: avec le liens de l'application sur le googlestore
- `appstoreURL`: avec le lien de l'application sur AppStore

### POUR CAPTCHA GOOGLE

1. Installation gcloud si non installé

- Rendez-vous sur [Installer gcloud CLI](https://cloud.google.com/sdk/docs/install?hl=fr)
  - Se rendre directement à l'étape 2 télécharger le package :
    - [google-cloud-cli-410.0.0-darwin-x86_64.tar.gz] selon mac.
- Ajouter dans le path .zsrch ou .bashrc

```bash
$export PATH="$PATH:/Users/kosmos/google-cloud-sdk/bin"
```

2. Initiatilisation et création de la key captcha

- Connexion au compte du client

```bash
$ gcloud init
```

- Génerer la clef APi
  - changer [nom-de-application-key]
  - changer [nom-du-projet.web.app]

```bash
$ gcloud recaptcha keys create --web --display-name=[nom-de-application-key] --integration-type=CHECKBOX --domains=[nom-du-projet.web.app], ...
```

- Dans le fichier [config](public/config.js)
  - `captcha_key`: renseigner la key créée

### Deployer

```bash
$ firebase deploy
```

<!-- ## POUR EMAIL -->

<!-- ### SENDGRID

1. npm install dans ./functions
2. Se connecter à SendGrid,
   => Créer un sender avec l'adresse gmail du client to adresse gmail du client. Ex: projet.dev@gmail.com
   => dans Api Key créer une clef
3. firebase functions:config:set sengrid.api_key=" CLEF API "
   deploy ! -->

## MAILERSEND

1. Installation des dépendances

```bash
$ cd /functions npm install
```

2. Se connectez à mailerSend avec le compte client

- Récupérez la clef

```bash
$ firebase functions:config:set mailer.api_key="[nom-de-application-key] "
```

- Dans le fichier [config](public/config.js)
- `googleCloudUrl`: renseigner l'url de la cloud function onSendLandingPageMail
- Créer un domaine sécurisé avec le nom de domain web.app

3. autorisation cloud function :

- Rendez-vous sur [GCP](https://console.cloud.google.com/functions/?_ga=2.114746498.462219227.1673863969-458468010.1668693216&_gac=1.127124991.1673254791.CjwKCAiAk--dBhABEiwAchIwkREx8kPBu7QqFodpOZGCqMki8AwySbbVXFyaALLl60RPO-y2IHIQOBoCAOwQAvD_BwE)
  - selectionnez votre projet
  - selectionnez la cloud 'onSendLandingPageMail'
    - Autorisations > + ACCORDER L'ACCÈS
    - "nouveaux comptes principaux" = "allUsers"
    - Sélectionnez un rôle : Cloud Functions -> demandeur cloud functions

```bash
$ firebase deploy
```
