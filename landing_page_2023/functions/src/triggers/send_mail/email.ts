import * as f from 'firebase-functions';
import * as express from 'express';
import * as cors from 'cors';
import { MailerSend, EmailParams, Sender, Recipient } from "mailersend";


const { mailer } = f.config();
const app = express();
app.use(cors({ origin: true }));


export default async (req: express.Request, res : express.Response,) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept,Authorization");

    try{
        const {name, email, subject, message} = req.body;
        res.status(200).send({ message: 'Data received' });

        const emailContent = generateEmail(name,  subject, email, message);

        const mailerSend = new MailerSend({
            apiKey: mailer.api_key,
          });

          const recipients = [
            new Recipient("findyourdresses.dev@gmail.com", "MY CLIENT")
          ];

        const sentFrom = new Sender('noreply@findyourdresses.com', 'FindYourDresses');

          const emailParams = new EmailParams()
          .setFrom(sentFrom)
          .setTo(recipients)
          .setReplyTo(sentFrom)
          .setSubject("Demande de renseignement")
            .setHtml(emailContent);
      
          if (req.body != null) {
            const rep = await mailerSend.email.send(emailParams);
            f.logger.info(rep);
          }
       
        return null;    

    }catch(e){
        f.logger.error("[Error] sendContactEmail: ", e);
        return { error: e };
    }

    }

    function generateEmail(name:string, subject:string, email:string, message:string ){
         return `<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
         <html>
           <head>
             <!-- Compiled with Bootstrap Email version: 1.1.5 --><meta http-equiv="x-ua-compatible" content="ie=edge">
             <meta name="x-apple-disable-message-reformatting">
             <meta name="viewport" content="width=device-width, initial-scale=1">
             <meta name="format-detection" content="telephone=no, date=no, address=no, email=no">
             <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
             <style type="text/css">
               body,table,td{font-family:Helvetica,Arial,sans-serif !important}.ExternalClass{width:100%}.ExternalClass,.ExternalClass p,.ExternalClass span,.ExternalClass font,.ExternalClass td,.ExternalClass div{line-height:150%}a{text-decoration:none}*{color:inherit}a[x-apple-data-detectors],u+#body a,#MessageViewBody a{color:inherit;text-decoration:none;font-size:inherit;font-family:inherit;font-weight:inherit;line-height:inherit}img{-ms-interpolation-mode:bicubic}table:not([class^=s-]){font-family:Helvetica,Arial,sans-serif;mso-table-lspace:0pt;mso-table-rspace:0pt;border-spacing:0px;border-collapse:collapse}table:not([class^=s-]) td{border-spacing:0px;border-collapse:collapse}@media screen and (max-width: 600px){.w-full,.w-full>tbody>tr>td{width:100% !important}*[class*=s-lg-]>tbody>tr>td{font-size:0 !important;line-height:0 !important;height:0 !important}.s-2>tbody>tr>td{font-size:8px !important;line-height:8px !important;height:8px !important}.s-3>tbody>tr>td{font-size:12px !important;line-height:12px !important;height:12px !important}.s-5>tbody>tr>td{font-size:20px !important;line-height:20px !important;height:20px !important}.s-10>tbody>tr>td{font-size:40px !important;line-height:40px !important;height:40px !important}}
             </style>
           </head>
           <body class="bg-light" style="outline: 0; width: 100%; min-width: 100%; height: 100%; -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; font-family: Helvetica, Arial, sans-serif; line-height: 24px; font-weight: normal; font-size: 16px; -moz-box-sizing: border-box; -webkit-box-sizing: border-box; box-sizing: border-box; color: #000000; margin: 0; padding: 0; border-width: 0;" bgcolor="#f7fafc">
             <table class="bg-light body" valign="top" role="presentation" border="0" cellpadding="0" cellspacing="0" style="outline: 0; width: 100%; min-width: 100%; height: 100%; -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; font-family: Helvetica, Arial, sans-serif; line-height: 24px; font-weight: normal; font-size: 16px; -moz-box-sizing: border-box; -webkit-box-sizing: border-box; box-sizing: border-box; color: #000000; margin: 0; padding: 0; border-width: 0;" bgcolor="#f7fafc">
               <tbody>
                 <tr>
                   <td valign="top" style="line-height: 24px; font-size: 16px; margin: 0;" align="left" bgcolor="#f7fafc">
                     <table class="container" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                       <tbody>
                         <tr>
                           <td align="center" style="line-height: 24px; font-size: 16px; margin: 0; padding: 0 16px;">
                             <!--[if (gte mso 9)|(IE)]>
                               <table align="center" role="presentation">
                                 <tbody>
                                   <tr>
                                     <td width="600">
                             <![endif]-->
                             <table align="center" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%; max-width: 600px; margin: 0 auto;">
                               <tbody>
                                 <tr>
                                   <td style="line-height: 24px; font-size: 16px; margin: 0;" align="left">
                                     <table class="s-10 w-full" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;" width="100%">
                                       <tbody>
                                         <tr>
                                           <td style="line-height: 40px; font-size: 40px; width: 100%; height: 40px; margin: 0;" align="left" width="100%" height="40">
                                             &#160;
                                           </td>
                                         </tr>
                                       </tbody>
                                     </table>
                                     <table class="card" role="presentation" border="0" cellpadding="0" cellspacing="0" style="border-radius: 6px; border-collapse: separate !important; width: 100%; overflow: hidden; border: 1px solid #e2e8f0;" bgcolor="#ffffff">
                                       <tbody>
                                         <tr>
                                           <td style="line-height: 24px; font-size: 16px; width: 100%; margin: 0;" align="left" bgcolor="#ffffff">
                                             <table class="card-body" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                                               <tbody>
                                                 <tr>
                                                   <td style="line-height: 24px; font-size: 16px; width: 100%; margin: 0; padding: 20px;" align="left">
                                                     <h1 class="h3" style="padding-top: 0; padding-bottom: 0; font-weight: 500; vertical-align: baseline; font-size: 28px; line-height: 33.6px; margin: 0;" align="left">FindYourDresses</h1>
                                                     <table class="s-2 w-full" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;" width="100%">
                                                       <tbody>
                                                         <tr>
                                                           <td style="line-height: 8px; font-size: 8px; width: 100%; height: 8px; margin: 0;" align="left" width="100%" height="8">
                                                             &#160;
                                                           </td>
                                                         </tr>
                                                       </tbody>
                                                     </table>
                                                     <h5 class="text-teal-700" style="color: #000000; padding-top: 0; padding-bottom: 0; font-weight: 500; vertical-align: baseline; font-size: 20px; line-height: 24px; margin: 0;" align="left">Nouvelle demande de contact</h5>
                                                     <table class="s-5 w-full" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;" width="100%">
                                                       <tbody>
                                                         <tr>
                                                           <td style="line-height: 20px; font-size: 20px; width: 100%; height: 20px; margin: 0;" align="left" width="100%" height="20">
                                                             &#160;
                                                           </td>
                                                         </tr>
                                                       </tbody>
                                                     </table>
                                                     <table class="hr" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                                                       <tbody>
                                                         <tr>
                                                           <td style="line-height: 24px; font-size: 16px; border-top-width: 1px; border-top-color: #e2e8f0; border-top-style: solid; height: 1px; width: 100%; margin: 0;" align="left">
                                                           </td>
                                                         </tr>
                                                       </tbody>
                                                     </table>
                                                     <table class="s-5 w-full" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;" width="100%">
                                                       <tbody>
                                                         <tr>
                                                           <td style="line-height: 20px; font-size: 20px; width: 100%; height: 20px; margin: 0;" align="left" width="100%" height="20">
                                                             &#160;
                                                           </td>
                                                         </tr>
                                                       </tbody>
                                                     </table>
                                                     <div class="space-y-3">
                                                       <p class="text-gray-700" style="line-height: 24px; font-size: 16px; color: #4a5568; width: 100%; margin: 0;" align="left">Nom : ${name}</p>
                                                       <p class="text-gray-700" style="line-height: 24px; font-size: 16px; color: #4a5568; width: 100%; margin: 0;" align="left">Email : ${email}</p>
                                                       <p class="text-gray-700" style="line-height: 24px; font-size: 16px; color: #4a5568; width: 100%; margin: 0;" align="left">Sujet : ${subject}</p>

                                                       <table class="s-3 w-full" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;" width="100%">
                                                         <tbody>
                                                           <tr>
                                                             <td style="line-height: 12px; font-size: 12px; width: 100%; height: 12px; margin: 0;" align="left" width="100%" height="12">
                                                               &#160;
                                                             </td>
                                                           </tr>
                                                         </tbody>
                                                       </table>
                                                       <p class="text-gray-700" style="line-height: 24px; font-size: 16px; color: #4a5568; width: 100%; margin: 0;" align="left">
                                                       Message : ${message}
                                                       </p>
                                                       <table class="s-3 w-full" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;" width="100%">
                                                         <tbody>
                                                           <tr>
                                                             <td style="line-height: 12px; font-size: 12px; width: 100%; height: 12px; margin: 0;" align="left" width="100%" height="12">
                                                               &#160;
                                                             </td>
                                                           </tr>
                                                         </tbody>
                                                       </table>
                                                      
                                                       <table class="s-3 w-full" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;" width="100%">
                                                         <tbody>
                                                           <tr>
                                                             <td style="line-height: 12px; font-size: 12px; width: 100%; height: 12px; margin: 0;" align="left" width="100%" height="12">
                                                               &#160;
                                                             </td>
                                                           </tr>
                                                         </tbody>
                                                       </table>
                                                      
                                                     </div>
                                                     <table class="s-5 w-full" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;" width="100%">
                                                       <tbody>
                                                         <tr>
                                                           <td style="line-height: 20px; font-size: 20px; width: 100%; height: 20px; margin: 0;" align="left" width="100%" height="20">
                                                             &#160;
                                                           </td>
                                                         </tr>
                                                       </tbody>
                                                     </table>
                                                     <table class="hr" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
                                                       <tbody>
                                                         <tr>
                                                           <td style="line-height: 24px; font-size: 16px; border-top-width: 1px; border-top-color: #e2e8f0; border-top-style: solid; height: 1px; width: 100%; margin: 0;" align="left">
                                                           </td>
                                                         </tr>
                                                       </tbody>
                                                     </table>
                                                     <table class="s-5 w-full" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;" width="100%">
                                                       <tbody>
                                                         <tr>
                                                           <td style="line-height: 20px; font-size: 20px; width: 100%; height: 20px; margin: 0;" align="left" width="100%" height="20">
                                                             &#160;
                                                           </td>
                                                         </tr>
                                                       </tbody>
                                                     </table>
                                                     
                                                   </td>
                                                 </tr>
                                               </tbody>
                                             </table>
                                           </td>
                                         </tr>
                                       </tbody>
                                     </table>
                                     <table class="s-10 w-full" role="presentation" border="0" cellpadding="0" cellspacing="0" style="width: 100%;" width="100%">
                                       <tbody>
                                         <tr>
                                           <td style="line-height: 40px; font-size: 40px; width: 100%; height: 40px; margin: 0;" align="left" width="100%" height="40">
                                             &#160;
                                           </td>
                                         </tr>
                                       </tbody>
                                     </table>
                                   </td>
                                 </tr>
                               </tbody>
                             </table>
                             <!--[if (gte mso 9)|(IE)]>
                             </td>
                           </tr>
                         </tbody>
                       </table>
                             <![endif]-->
                           </td>
                         </tr>
                       </tbody>
                     </table>
                   </td>
                 </tr>
               </tbody>
             </table>
           </body>
         </html>
         `

    }

