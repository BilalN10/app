import lazy from "../lazy"
import { https } from 'firebase-functions'

export const onSendLandingPageMail = https.onRequest(lazy("./triggers/send_mail/email"));

