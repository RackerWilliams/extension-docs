#!/usr/bin/perl
use CGI::Carp 'fatalsToBrowser';
sub OutputDocList{
  my ($dirname) = @_;
  opendir my($dh), $dirname or die "Couldn't open dir '$dirname': $!";
  my @files = grep { !/^\./ } readdir $dh; 
  closedir $dh;
  foreach(@files){
      print "<a href='${dirname}/${_}'>" . $_ . "</a>";
      print "<br/>";
  }

}
print "Content-type: text/html\n\n";

print "<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01//EN'";
print "   'http://www.w3.org/TR/html4/strict.dtd'>";
print "   ";
print "    <html lang='en'>";
print "        <head>";
print "            <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>";
print "                <meta name='google-site-verification' content='Ip5yk0nd8yQHEo8I7SjzVfAiadlHvTvqQHLGwn1GFyU' />";
print "                <title>OpenStack Extensions Documentation</title>";
print "                ";
print "                <!-- Google Fonts -->";
print "                <link href='http://fonts.googleapis.com/css?family=PT+Sans&subset=latin' rel='stylesheet' type='text/css'>";
print "                    ";
print "                    <!-- Framework CSS -->";
print "                    <link rel='stylesheet' href='http://openstack.org/themes/openstack/css/blueprint/screen.css' type='text/css' media='screen, projection'>";
print "                        <link rel='stylesheet' href='http://openstack.org/themes/openstack/css/blueprint/print.css' type='text/css' media='print'>";
print "                            <!--[if lt IE 8]><link rel='stylesheet' href='http://openstack.org/themes/openstack/css/blueprint/ie.css' type='text/css' media='screen, projection'><![endif]-->";
print "                            ";
print "                            <!-- OpenStack Specific CSS -->";
print "                            <link rel='stylesheet' href='http://openstack.org/themes/openstack/css/main.css' type='text/css' media='screen, projection, print'>";
print "                                ";
print "                                <link rel='stylesheet' type='text/css' href='http://docs.openstack.org/common/css/new-homepage.css'>    ";
print "                                    ";
print "                                    <link rel='stylesheet' type='text/css' href='/shadowbox/shadowbox.css'>    ";
print "                                        ";
print "                                        <script type='text/javascript'>";
print "    ";
print "      var _gaq = _gaq || [];";
print "      _gaq.push(['_setAccount', 'UA-17511903-6']);";
print "      _gaq.push(['_setDomainName', '.openstack.org']);";
print "      _gaq.push(['_trackPageview']);";
print "    ";
print "      (function() {";
print "        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;";
print "        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';";
print "        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);";
print "      })();";
print "    ";
print "    </script>";
print "                                        ";
print "                                        ";
print "        </head>";
print "        <body class='docshome' id='docshome'>  	";
print "            ";
print "            <div class='container'>";
print "                <p><i>This page temporarily located on rackspace.com.  It will move to the OpenStack site eventually.</i></p>";
print "                <div id='header'> ";
print "                    <div class='span-5'> ";
print "                        <h1 id='logo'><a href='http://www.openstack.org/'>Open Stack</a></h1> ";
print "                    </div> ";
print "                    <div class='span-19 last'> ";
print "                        ";
print "                        <div id='navigation'> ";
print "                            <ul id='Menu1'> ";
print "                                ";
print "                                <li><a href='http://www.openstack.org/' title='Go to the Home page' class='link'>Home</a></li> ";
print "                                ";
print "                                <li><a href='http://www.openstack.org/projects/' title='Go to the OpenStack Projects page'>Projects</a></li> ";
print "                                ";
print "                                <li><a href='http://www.openstack.org/community/' title='Go to the Community page' class='link'>Community</a></li> ";
print "                                ";
print "                                <li><a href='http://www.openstack.org/blog/' title='Go to the OpenStack Blog'>Blog</a></li> ";
print "                                <li><a href='http://wiki.openstack.org/' title='Go to the OpenStack Wiki'>Wiki</a></li> ";
print "                                <li><a href='http://docs.openstack.org/' title='Go to OpenStack Documentation'>Documentation</a></li> ";
print "                                <li><a href='#' title='Go to OpenStack Extentions Documentation' class='current'>Extensions Documentation</a></li> ";
print "                            </ul> ";
print "                        </div> ";
print "                        ";
print "                    </div> ";
print "                </div> ";
print "            </div> ";
print "            <!-- Page Content -->";
print "            ";
print "            <div class='container'>";
print "                <div class='searchArea span-16 prepend-4'>";
print "                    <h1>Search All OpenStack Manuals</h1>";
print "                    ";
print "                    <div id='cse' style='width: 100%;'>Loading</div>";
print "                    <script src='http://www.google.com/jsapi' type='text/javascript'></script>";
print "                    <script type='text/javascript'> ";
print "  google.load('search', '1', {language : 'en'});";
print "  var _gaq = _gaq || [];";
print "  _gaq.push(['_setAccount', 'UA-17511903-6']);";
print "  function _trackQuery(control, searcher, query) {";
print "    var gaQueryParamName = 'q';";
print "    var loc = document.location;";
print "    var url = [";
print "      loc.pathname,";
print "      loc.search,";
print "      loc.search ? '&' : '?',";
print "      gaQueryParamName == '' ? 'q' : encodeURIComponent(gaQueryParamName),";
print "      '=',";
print "      encodeURIComponent(query)";
print "    ].join('');";
print "    _gaq.push(['_trackPageview', url]);";
print "  }";
print "  google.setOnLoadCallback(function() {";
print "    var customSearchControl = new google.search.CustomSearchControl('011012898598057286222:elxsl505o0o');";
print "    customSearchControl.setResultSetSize(google.search.Search.FILTERED_CSE_RESULTSET);";
print "    customSearchControl.setSearchStartingCallback(null, _trackQuery);";
print "    customSearchControl.draw('cse');";
print "  }, true);";
print "</script></div>";
print "                <!--";
print "                    <link rel='stylesheet' href='http://www.google.com/cse/style/look/default.css' type='text/css' /> -->";
print "                <!-- <div id='cse' style='width: 100%;'>Loading</div>";
print "                    <script src='http://www.google.com/jsapi' type='text/javascript'></script>";
print "                    <script type='text/javascript'>";
print "                    google.load('search', '1', {language : 'en'});";
print "                    google.setOnLoadCallback(function() {";
print "                    var customSearchControl = new google.search.CustomSearchControl('011012898598057286222:elxsl505o0o');";
print "                    customSearchControl.setResultSetSize(google.search.Search.FILTERED_CSE_RESULTSET);";
print "                    customSearchControl.draw('cse');";
print "                    }, true);";
print "                    </script>";
print "                    </div> -->";
print "            </div>";
print "<div class='container'>";
print "<div id='extensions' class='span-16'>";
print "<style>";
print "    #oedtable{";
print "        position:relative;";
print "        width:120%";
print "        }";
print "    #oedfirstcolumn,#oedsecondcolumn,#oedthirdcolumn,#oedfourthcolumn{";
print "       width:25%;";
print "       top:0;";
print "       }";
print "    #oedsecondcolumn{";
print "        position:absolute;";
print "        left:25%;";
print "    }";
print "    #oedthirdcolumn{";
print "        position:absolute;";
print "        left:50%;";
print "    }";
print "    #oedfourthcolumn{";
print "        position:absolute;";
print "        left:75%;";
print "    }";
print "    #logo a{background-image:url(images/built-for-openstack.png);height:170px}";
print "    div.searchArea{display:none;position:absolute;top:110px;left:65px;width:630px}";
print "    p.tablehead{font-size:1.2em;font-weight:bold;margin-bottom:0}";
print "    .span-16{width:800px}";
print "</style>                ";
print "<h2 class='head'>OpenStack Extensions Documentation</h2>  ";
print "    This page is for documentation of OpenStack extensions. For OpenStack extensions";
print "        themselves, see <a href='#'>OpenStack Extensions</a> (doesn't exist yet).";
print "        <h3 class='subhead'>Document List</h3>";
print "    <div id='oedtable'>";
print "    <div id='oedfirstcolumn'>";
print "        <p class='tablehead'>Compute</p>";
               OutputDocList("compute");
print "    </div>";
print "    <div id='oedsecondcolumn'>";
print "        <p class='tablehead'>Auth</p>";
               OutputDocList("auth");
print "    </div>";
print "    <div id='oedthirdcolumn'>";
print "        <p class='tablehead'>Load Balancing</p>";
               OutputDocList("lb");
print "    </div>";
print "    <div id='oedfourthcolumn'>";
print "        <p class='tablehead'>Networking</p>";
               OutputDocList("network");
print "    </div>";
print "    </div>";
print "    </div><div id='submit_extensions' class='span-16'>";
print "<br/><br/>";
print "        <h4 class='head'>Submitting a new Extension Document</h3>";
print "        <p>For your document source, you can use our recommended formats (DocBook or ReStructured Text) or whatever you want.  Please submit your HTML output,";
print "            eiher as a single HTML file or a directory, by zipping it up and emailing it to <a href='mailto:extensions\@openstack.org'>extensions\@openstack.org</a>.</p>";

print "        <h4 class='head'>Starting a New Extensions Document</h3>";
print "        <p>Although you can use any format, using our docbook template ensures your document will merge seemlessly into the documentaiton system.";
print "            Click here to download the <a href='openstack-extension-template.zip'>docbook template</a> (zip file).";
print "        </p>";
print "        <p>You also need to have maven available.</p>";
print "        <p>  ";
print "            The zip file contains an entire template project. ";
print "            To create your project, </p>";
print "        <ol>";
print "            <li>Modify the POM file to specify your project's name.</li>";
print "            <li>Rename <tt>src/main/resources/ext_template.xml</tt> ";
print "        to a name that fits your project</li>";
print "            <li>Write your documentation in that file.";
print "            </li>";
print "            <li>Test your documentation by, within the project directory, executing:<br/>";
print "               <tt>mvn generate-sources</tt><br/>";
print "            </li>          ";
print "        </ol>";
print "    </div></div>";
print "    </body>";
print "</html>";

