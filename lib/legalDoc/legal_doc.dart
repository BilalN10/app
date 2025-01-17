import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import './static_doc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class LegalDocPage extends StatefulWidget {
  final LegalDoc type;
  const LegalDocPage({super.key, required this.type});

  @override
  State<LegalDocPage> createState() => _LegalDocPageState();
}

class _LegalDocPageState extends State<LegalDocPage> {
  String? pathPDF;
  @override
  void initState() {
    super.initState();

    getFile();
  }

  void getFile() {
    if (widget.type == LegalDoc.legalNotice) return;
    fromAsset(widget.type.path, widget.type.fileName).then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.type == LegalDoc.legalNotice
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 20.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CTA.back(
                  onTap: () {
                    AutoRouter.of(context).navigateBack();
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        HtmlWidget("""
<p><strong><span data-contrast="auto">MENTIONS LEGALES&nbsp;</span></strong></p>
                    <ol>
                        <li data-leveltext="%1." data-font="Calibri" data-listid="2"
                            data-list-defn-props="{&quot;335552541&quot;:0,&quot;335559684&quot;:-1,&quot;335559685&quot;:360,&quot;335559991&quot;:360,&quot;469769242&quot;:[65533,0],&quot;469777803&quot;:&quot;left&quot;,&quot;469777804&quot;:&quot;%1.&quot;,&quot;469777815&quot;:&quot;hybridMultilevel&quot;}"
                            data-aria-posinset="1" data-aria-level="1"><strong><span data-contrast="auto"><span
                                        data-ccp-para=""
                                        data-ccp-parastyle-defn="{&quot;ObjectId&quot;:&quot;f0321f91-64b6-4f86-ad25-400865cd9cb7|36&quot;,&quot;ClassId&quot;:1073872969,&quot;Properties&quot;:[469775450,&quot;Lettre&quot;,201340122,&quot;2&quot;,134233614,&quot;true&quot;,469778129,&quot;Lettre&quot;,335572020,&quot;1&quot;,469777841,&quot;Times New Roman&quot;,469777842,&quot;Arial&quot;,469777843,&quot;Times New Roman&quot;,469777844,&quot;Times New Roman&quot;,469769226,&quot;Times New Roman,Arial&quot;,268442635,&quot;24&quot;]}">Identit&eacute;</span><span
                                        data-ccp-para=""> de l&rsquo;</span><span
                                        data-ccp-para="">exploitant</span></span></strong></li>
                    </ol>
                    <p><span data-contrast="auto"><span data-ccp-para=""
                                data-ccp-parastyle-defn="{&quot;ObjectId&quot;:&quot;f0321f91-64b6-4f86-ad25-400865cd9cb7|48&quot;,&quot;ClassId&quot;:1073872969,&quot;Properties&quot;:[469775450,&quot;LO-Normal&quot;,201340122,&quot;2&quot;,134233614,&quot;true&quot;,469778129,&quot;LO-Normal&quot;,335572020,&quot;1&quot;,469777841,&quot;Calibri&quot;,469777842,&quot;Times New Roman&quot;,469777843,&quot;Calibri&quot;,469777844,&quot;Calibri&quot;,469769226,&quot;Calibri,Times New Roman&quot;,268442635,&quot;22&quot;,335559705,&quot;1033&quot;,335559740,&quot;252&quot;,201341983,&quot;0&quot;,335559739,&quot;160&quot;]}">D&eacute;nomination</span><span
                                data-ccp-para="">sociale :</span><span data-ccp-para="">FIND YOUR DRESSES</span></span></p>
                    <p><span data-contrast="auto"><span data-ccp-para="">Forme </span><span
                                data-ccp-para="">juridique</span><span data-ccp-para=""> : </span><span
                                data-ccp-para="">SAS</span></span></p>
                    <p><span data-contrast="auto"><span data-ccp-para="">Pr&eacute;sident</span><span data-ccp-para=""> :
                            </span><span data-ccp-para="">In&egrave;s</span><span data-ccp-para=""> REZIG</span></span></p>
                    <p><span data-contrast="auto"><span data-ccp-para="">Capital </span><span
                                data-ccp-para="">social :</span><span data-ccp-para="">1000&euro;</span></span></p>
                    <p><span data-contrast="auto"><span data-ccp-para="">Si&egrave;ge</span><span
                                data-ccp-para="">social:</span><span data-ccp-para="">10 </span><span
                                data-ccp-para="">All&eacute;e</span><span data-ccp-para=""> de la </span><span
                                data-ccp-para="">Verveine</span><span data-ccp-para=""> &ndash; 69800 SAINT
                                PRIEST</span></span></p>
                    <p><span data-contrast="auto"><span data-ccp-para="">RCS</span><span data-ccp-para=""> </span><span
                                data-ccp-para="">LYON</span><span data-ccp-para="">:</span><span
                                data-ccp-para="">904</span><span data-ccp-para=""> </span><span
                                data-ccp-para="">228</span><span data-ccp-para="">871</span></span></p>
                    <p><span data-contrast="auto"><span data-ccp-para="">Num&eacute;ro</span><span data-ccp-para=""> de TVA
                            </span><span data-ccp-para="">intracommunautaire</span><span data-ccp-para=""> : </span><span
                                data-ccp-para="">FR48904228871</span></span></p>
                    <p><span data-contrast="auto">N&deg; t&eacute;l. : 07.71.08.56.88</span></p>
                    <p><span data-contrast="auto">Email : contact@findyourdresses.com</span></p>
                    <p><strong><span data-contrast="auto">Directeur de la publication </span></strong><strong><span
                                data-contrast="auto">:</span></strong><span data-contrast="auto"> In&egrave;s REZIG</span>
                    </p>
                    <p><span data-ccp-props="{&quot;201341983&quot;:0,&quot;335559739&quot;:0,&quot;335559740&quot;:240}">&nbsp;2
                            .</span><strong><span data-contrast="auto">H&eacute;bergeur </span></strong></p>
                    <p><span data-contrast="auto"><span data-ccp-para="">D&eacute;nomination</span><span
                                data-ccp-para="">sociale :</span><span data-ccp-para=""> WIX</span></span></p>
                    <p><span data-contrast="auto"><span data-ccp-para="">Si&egrave;ge</span><span
                                data-ccp-para="">social :</span><span data-ccp-para=""> TEL AVIV ISRAEL&nbsp;</span></span>
                    </p>
                    <p><span
                            data-ccp-props="{&quot;201341983&quot;:0,&quot;335559739&quot;:0,&quot;335559740&quot;:240}">&nbsp;3.</span><strong><span
                                data-contrast="auto">Propriete intellectuelle &ndash; Protection des base de
                                donnees</span></strong></p>
                    <p><span data-contrast="auto">Tous les &eacute;l&eacute;ments de l&rsquo;Application, qu'ils soient
                            visuels ou sonores, y compris la technologie sous-jacente, ainsi que le nom et les services
                            propos&eacute;s sont prot&eacute;g&eacute;s par un droit de propri&eacute;t&eacute;
                            intellectuelle tel que droit d'auteur, marque ou brevet. Ils sont la propri&eacute;t&eacute;
                            exclusive de FIND YOUR DRESSES, de ses partenaires ou de ses fournisseurs de contenu. Toute
                            reproduction, repr&eacute;sentation ou r&eacute;utilisation, en tout ou partie, sur un
                            quelconque support est interdite. Le non-respect de cette interdiction constitue une
                            contrefa&ccedil;on pouvant engager la responsabilit&eacute; civile et p&eacute;nale du
                            contrefacteur. L&rsquo;Internaute qui dispose d'un site Internet ou d&rsquo;une application
                            &agrave; titre personnel et qui d&eacute;sire placer, pour un usage personnel, sur son site ou
                            son application un lien simple renvoyant directement &agrave; l&rsquo;Application, doit
                            obligatoirement en demander l'autorisation &eacute;crite et pr&eacute;alable &agrave; FIND YOUR
                            DRESSES, sans que cette autorisation puisse &ecirc;tre consid&eacute;r&eacute;e comme un accord
                            implicite d&rsquo;affiliation. Dans tous les cas, tout lien devra &ecirc;tre retir&eacute; sur
                            simple demande de FIND YOUR DRESSES.</span></p>
                    <p><span data-contrast="auto">Il est interdit d&rsquo;extraire et/ou de r&eacute;utiliser de
                            fa&ccedil;on syst&eacute;matique des parties de l&rsquo;Application sans l&rsquo;autorisation
                            &eacute;crite et pr&eacute;alable de FIND YOUR DRESSES. En particulier, il est interdit
                            d&rsquo;utiliser de robot d'aspiration de donn&eacute;es, ou tout autre outil similaire de
                            collecte ou d'extraction de donn&eacute;es pour extraire (en une ou plusieurs fois), pour
                            r&eacute;utiliser une partie substantielle de l&rsquo;Application sans l&rsquo;autorisation
                            &eacute;crite et pr&eacute;alable de FIND YOUR DRESSES. Il est interdit de cr&eacute;er et/ou de
                            publier des propres bases de donn&eacute;es qui comporteraient des parties substantielles de
                            l&rsquo;Application sans l&rsquo;autorisation &eacute;crite et pr&eacute;alable de FIND YOUR
                            DRESSES.</span></p>
                    <p><span
                            data-ccp-props="{&quot;201341983&quot;:0,&quot;335551550&quot;:6,&quot;335551620&quot;:6,&quot;335559739&quot;:0,&quot;335559740&quot;:240,&quot;469777462&quot;:[4086],&quot;469777927&quot;:[0],&quot;469777928&quot;:[3]}">&nbsp;4.&nbsp;</span><strong><span
                                data-contrast="auto"><span data-ccp-char=""
                                    data-ccp-charstyle-defn="{&quot;ObjectId&quot;:&quot;f0321f91-64b6-4f86-ad25-400865cd9cb7|42&quot;,&quot;ClassId&quot;:1073872969,&quot;Properties&quot;:[469775450,&quot;txt&quot;,201340122,&quot;1&quot;,134233614,&quot;true&quot;,469778129,&quot;txt&quot;,335572020,&quot;1&quot;]}">R</span><span
                                    data-ccp-char="">esponsabilite</span></span></strong></p>
                    <p><span data-contrast="auto"><span data-ccp-char="">FIND YOUR DRESSES</span><span data-ccp-char=""> ne
                                peut pas &ecirc;tre tenue responsable des interruptions de services dues aux
                                caract&eacute;ristiques et limites du r&eacute;seau Internet notamment dans le cas
                                d&rsquo;interruption des r&eacute;seaux d&rsquo;acc&egrave;s, des performances techniques et
                                des temps de r&eacute;ponse pour consulter</span><span data-ccp-char="">les informations
                                contenues sur</span></span><span data-contrast="auto"><span
                                data-ccp-para="">l&rsquo;Application</span></span><span data-contrast="auto"><span
                                data-ccp-char="">. </span><span data-ccp-char="">FIND YOUR DRESSES</span><span
                                data-ccp-char=""> n&rsquo;est aucunement responsable des interruptions de
                                services</span></span><span data-contrast="auto"><span data-ccp-para="">de</span><span
                                data-ccp-para="">l&rsquo;Application</span></span><span data-contrast="auto"><span
                                data-ccp-char="">li&eacute;es &agrave; des difficult&eacute;s techniques ou
                                autres.</span></span></p>
                    <p><span data-contrast="auto"><span data-ccp-char="">Compte tenu des caract&eacute;ristiques
                                intrins&egrave;ques de l&rsquo;Internet, </span><span data-ccp-char="">FIND YOUR
                                DRESSES</span><span data-ccp-char=""> ne garantit pas l&rsquo;</span><span
                                data-ccp-char="">Internaute</span><span data-ccp-char=""> contre les risques notamment de
                                d&eacute;tournement, d&rsquo;intrusion, de contamination et de piratage de ses
                                donn&eacute;es, programmes et fichiers. Il appartient &agrave; l&rsquo;</span><span
                                data-ccp-char="">Internaute</span><span data-ccp-char=""> de prendre toutes mesures
                                appropri&eacute;es de nature &agrave; prot&eacute;ger ses propres donn&eacute;es, programmes
                                et fichiers notamment contre les virus informatiques.</span></span></p>
                    <p><span data-contrast="auto"><span data-ccp-para="">FIND YOUR DRESSES</span><span data-ccp-para="">
                                n&rsquo;assume aucun engagement ni responsabilit&eacute;, de quelque forme que ce soit, en
                                ce qui concerne :&nbsp;</span></span></p>
                    <ul>
                        <li data-leveltext="-" data-font="Verdana Pro SemiBold" data-listid="1"
                            data-list-defn-props="{&quot;335552541&quot;:1,&quot;335559684&quot;:-2,&quot;335559685&quot;:360,&quot;335559991&quot;:360,&quot;469769226&quot;:&quot;Verdana Pro SemiBold&quot;,&quot;469769242&quot;:[8226],&quot;469777803&quot;:&quot;left&quot;,&quot;469777804&quot;:&quot;-&quot;,&quot;469777815&quot;:&quot;hybridMultilevel&quot;}"
                            data-aria-posinset="1" data-aria-level="1"><span data-contrast="auto"><span data-ccp-para="">Les
                                    cons&eacute;quences en cas de d&eacute;faillance des &eacute;quipements et/ou
                                    r&eacute;seaux informatiques d&rsquo;un </span><span
                                    data-ccp-para="">Internaute</span><span data-ccp-para=""> (ordinateur,
                                    t&eacute;l&eacute;phone etc.) ;&nbsp;</span></span></li>
                        <li data-leveltext="-" data-font="Verdana Pro SemiBold" data-listid="1"
                            data-list-defn-props="{&quot;335552541&quot;:1,&quot;335559684&quot;:-2,&quot;335559685&quot;:360,&quot;335559991&quot;:360,&quot;469769226&quot;:&quot;Verdana Pro SemiBold&quot;,&quot;469769242&quot;:[8226],&quot;469777803&quot;:&quot;left&quot;,&quot;469777804&quot;:&quot;-&quot;,&quot;469777815&quot;:&quot;hybridMultilevel&quot;}"
                            data-aria-posinset="2" data-aria-level="1"><span data-contrast="auto"><span data-ccp-para="">Les
                                    cons&eacute;quences en cas d&rsquo;interruption ou de d&eacute;faillance du
                                    r&eacute;seau Internet et/ou des services d&rsquo;acc&egrave;s &agrave; Internet
                                    ;&nbsp;</span></span></li>
                        <li data-leveltext="-" data-font="Verdana Pro SemiBold" data-listid="1"
                            data-list-defn-props="{&quot;335552541&quot;:1,&quot;335559684&quot;:-2,&quot;335559685&quot;:360,&quot;335559991&quot;:360,&quot;469769226&quot;:&quot;Verdana Pro SemiBold&quot;,&quot;469769242&quot;:[8226],&quot;469777803&quot;:&quot;left&quot;,&quot;469777804&quot;:&quot;-&quot;,&quot;469777815&quot;:&quot;hybridMultilevel&quot;}"
                            data-aria-posinset="3" data-aria-level="1"><span data-contrast="auto"><span data-ccp-para="">Les
                                    cons&eacute;quences du non-respect des consignes donn&eacute;es par </span><span
                                    data-ccp-para="">FIND YOUR DRESSES</span><span data-ccp-para="">.</span></span></li>
                    </ul>




""")
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : Stack(
            children: [
              Positioned.fill(
                child: pathPDF != null
                    ? PDFView(
                        nightMode: true,
                        fitEachPage: false,
                        autoSpacing: false,
                        filePath: pathPDF,
                      )
                    : SizedBox(),
              ),
              Positioned(
                  top: MediaQuery.of(context).padding.top + 20.h,
                  child: CTA.back(onTap: () {
                    AutoRouter.of(context).navigateBack();
                  }))
            ],
          );
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
