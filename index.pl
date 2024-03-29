#!/usr/bin/perl
use CGI::Carp 'fatalsToBrowser';
use File::Spec;
use POSIX qw(strftime);
use POSIX qw(ceil);
use XML::LibXML;
use XML::LibXML::XPathContext;

##
##  The directories are expected to be relative to the split path
##  @local_dir below. The names are used for the section titles.
##
if (!$num_ext_types) {
    @template_data = ({dir => "compute", name => "Compute Extensions"},
                      {dir => "auth",    name => "Identity Extensions"},
                      {dir => "network", name => "Network Extensions"},
                      {dir => "lb",      name => "Load Balancing Extensions"});
    $num_ext_types = scalar (@template_data);
}

##
##  The columns with their div class names.
##
if (!$num_columns) {
    @ext_columns = ("oedfirstcolumn", "oedsecondcolumn",
                    "oedthirdcolumn", "oedfourthcolumn");
    $num_columns = scalar(@ext_columns);
}

##
## The directory where we scan for extensions as a split path.
##

if (!scalar(@local_dir)) {
    @local_dir = File::Spec->splitpath(GetScriptDirectory());
}

##
##  How often to scan the directory for new updates, in seconds. Note
##  that this is only going to work if you're using mod_perl, if
##  mod_perl is not used the directory will be scanned with every
##  request.  The update is per-perl process.
##
$update_every = 600; # 10 Mins.

##
##  The current time
##
$current_time = time();

##
##  Walk through the template_data and fill in the template_text
##
sub AddTemplateText() {
    $template_text = "";
    for (my $i=0; $i < $num_ext_types; $i++) {
        my $full_dir = File::Spec->catpath($local_dir[0], $local_dir[1], $template_data[$i]{'dir'});

        opendir my($dh), $full_dir or die "Couldn't open dir '$full_dir' : $!";
        my @files = sort grep { !/^\./ } readdir $dh; 
        closedir $dh;

        my $num_files = scalar(@files);
        my $files_per_column = ceil ($num_files / $num_columns);
        my $next_max  = $files_per_column;
        my $col = 0;
        $template_text .= "<div class='oedextsection'>";
        $template_text .= "<h3 class='subhead'>$template_data[$i]{'name'}</h3>";
        $template_text .= "<div class='oedtable'>";
        $template_text .= "<div class='$ext_columns[$col]'>";
        for (my $j=0; $j < $num_files; $j++)  {
            $file = $files[$j];
            if (($col+1 < $num_columns) && ($j >= $next_max)) {
                $col++;
                $template_text .= "</div>";
                $template_text .= "<div class='$ext_columns[$col]'>";
                $next_max += $files_per_column;
            }
            my $ext_meta_file = File::Spec->catfile ($full_dir,$file,"content","ext_query.xml");
            if (-e $ext_meta_file) {
                eval {
                    my $ext_meta = XML::LibXML::XPathContext->new(XML::LibXML->new->parse_file($ext_meta_file));
                    $ext_meta->registerNs ("os","http://docs.openstack.org/common/api/v1.0");
                    my $ext_name  = $ext_meta->findvalue('//os:extension[1]/@name');
                    my $ext_desc  = $ext_meta->findvalue('normalize-space(//os:extension[1]/os:description)');
                    my $ext_alias = $ext_meta->findvalue('//os:extension[1]/@alias');

                    $template_text .= "<div class='oedextension'><div class='oedtitle'><a href='$template_data[$i]{'dir'}/$file/content'>" . $ext_name .
                        " (" . $ext_alias . ")</a></div>" . $ext_desc . "</div><br>";
                };
                if ($@) {
                    chomp $@;
                    $template_text .= "\n\n<!-- ERROR : $@ -->\n";
                    $template_text .=  "<div class='oedextension'><div class='oedtitle'><a href='$template_data[$i]{'dir'}/$file/content'>" . $file . "</a></div></div>";
                }
            } else {
                $template_text .=  "<div class='oedextension'><div class='oedtitle'><a href='$template_data[$i]{'dir'}/$file/content'>" . $file . "</a></div></div>";
            }
        }
        $template_text .= "</div></div></div>";
    }
}

##
##  Retrieves the current script directory
##
sub GetScriptDirectory() {
    $ret = $ENV{"SCRIPT_FILENAME"};
    if (!$ret) {
        $ret = "."
    }
    return $ret;
}

##
##  Add the template text (if nessasary)...
##
if (!$last_update ||
    ($current_time - $last_update) > $update_every) {

    ##
    ##  Update the, last update time.
    ##
    $last_update = $current_time;
    my $tz = strftime("%z", localtime($last_update));
    $tz =~ s/(\d{2})(\d{2})/$1:$2/;
    $last_update_txt = strftime("%Y-%m-%dT%H:%M:%S", localtime($last_update)) . $tz;

    AddTemplateText();
}

##
##  Print the actual output
##
print <<"EOT";
Content-type: text/html

<!DOCTYPE html PUBLIC '-//W3C//DTD HTML 4.01//EN'
   'http://www.w3.org/TR/html4/strict.dtd'>
   
    <html lang='en'>
        <head>
            <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
                <meta name='google-site-verification' content='Ip5yk0nd8yQHEo8I7SjzVfAiadlHvTvqQHLGwn1GFyU'>
                <title>OpenStack Extensions Documentation</title>
                
                <!-- Google Fonts -->
                <link href='http://fonts.googleapis.com/css?family=PT+Sans&amp;subset=latin' rel='stylesheet' type='text/css'>
                    
                    <!-- Framework CSS -->
                    <link rel='stylesheet' href='http://openstack.org/themes/openstack/css/blueprint/screen.css' type='text/css' media='screen, projection'>
                        <link rel='stylesheet' href='http://openstack.org/themes/openstack/css/blueprint/print.css' type='text/css' media='print'>
                            <!--[if lt IE 8]><link rel='stylesheet' href='http://openstack.org/themes/openstack/css/blueprint/ie.css' type='text/css' media='screen, projection'><![endif]-->
                            
                            <!-- OpenStack Specific CSS -->
                            <link rel='stylesheet' href='http://openstack.org/themes/openstack/css/main.css' type='text/css' media='screen, projection, print'>
                                
                                <link rel='stylesheet' type='text/css' href='http://docs.openstack.org/common/css/new-homepage.css'>    
                                    
                                    <link rel='stylesheet' type='text/css' href='/shadowbox/shadowbox.css'>    
                                        
                                        <script type='text/javascript'>
    
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-17511903-6']);
      _gaq.push(['_setDomainName', '.openstack.org']);
      _gaq.push(['_trackPageview']);
    
      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
    
    </script>
    <style type="text/css">
    .oedtable{
        position:relative;
        width:120%
        }
    .oedfirstcolumn,.oedsecondcolumn,.oedthirdcolumn,.oedfourthcolumn{
       width:25%;
       top:0;
       }
    .oedsecondcolumn{
        position:absolute;
        left:25%;
    }
    .oedthirdcolumn{
        position:absolute;
        left:50%;
    }
    .oedfourthcolumn{
        position:absolute;
        left:75%;
    }
   .oedextension {
      margin: 0;
      padding: .5em;
    }
    .oedextsection {
      margin-bottom: 1.5em;
      padding-bottom: 1.5em;
    }
    #logo a{background-image:url(images/built-for-openstack.png);height:170px}
    div.searchArea{display:none;position:absolute;top:110px;left:65px;width:630px}
    p.tablehead{font-size:1.2em;font-weight:bold;margin-bottom:0}
    .span-16{width:800px}
</style>
        </head>
        <body class='docshome' id='docshome'>  	
            
            <div class='container'>
                <div id='header'> 
                    <div class='span-5'> 
                        <h1 id='logo'><a href='http://www.openstack.org/'>Open Stack</a></h1> 
                    </div> 
                    <div class='span-19 last'> 
                        
                        <div id='navigation'> 
                            <ul id='Menu1'> 
                                
                                <li><a href='http://www.openstack.org/' title='Go to the Home page' class='link'>Home</a></li> 
                                
                                <li><a href='http://www.openstack.org/projects/' title='Go to the OpenStack Projects page'>Projects</a></li> 
                                
                                <li><a href='http://www.openstack.org/community/' title='Go to the Community page' class='link'>Community</a></li> 
                                
                                <li><a href='http://www.openstack.org/blog/' title='Go to the OpenStack Blog'>Blog</a></li> 
                                <li><a href='http://wiki.openstack.org/' title='Go to the OpenStack Wiki'>Wiki</a></li> 
                                <li><a href='http://docs.openstack.org/' title='Go to OpenStack Documentation' class='current'>Documentation</a></li> 
                            </ul> 
                        </div> 
                        
                    </div> 
                </div> 
            </div> 
            <!-- Page Content -->
            
            <div class='container'>
                <div class='searchArea span-16 prepend-4'>
                    <h1>Search All OpenStack Manuals</h1>
                    
                    <div id='cse' style='width: 100%;'>Loading</div>
                    <script src='http://www.google.com/jsapi' type='text/javascript'></script>
                    <script type='text/javascript'> 
  google.load('search', '1', {language : 'en'});
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-17511903-6']);
  function _trackQuery(control, searcher, query) {
    var gaQueryParamName = 'q';
    var loc = document.location;
    var url = [
      loc.pathname,
      loc.search,
      loc.search ? '&' : '?',
      gaQueryParamName == '' ? 'q' : encodeURIComponent(gaQueryParamName),
      '=',
      encodeURIComponent(query)
    ].join('');
    _gaq.push(['_trackPageview', url]);
  }
  google.setOnLoadCallback(function() {
    var customSearchControl = new google.search.CustomSearchControl('011012898598057286222:elxsl505o0o');
    customSearchControl.setResultSetSize(google.search.Search.FILTERED_CSE_RESULTSET);
    customSearchControl.setSearchStartingCallback(null, _trackQuery);
    customSearchControl.draw('cse');
  }, true);
</script></div>
            </div>
<div class='container'>
<div id='extensions' class='span-16'>
<h2 class='head'>OpenStack Extensions Documentation</h2>  
    This page provides documentation for OpenStack extensions. For documentation on the OpenStack extension mechinism 
    itself, see <a href='apix-intro/'>OpenStack Extensions</a>.
        $template_text
    </div><div id='submit_extensions' class='span-16'>
        <h4 class='head'>Submitting a new Extension Document</h4>
        <p>We accept exension documentaiton in our recommended formats (DocBook or ReStructured Text) or whatever you want.  Please submit your documentation to <a href='mailto:extensions\@openstack.org'>extensions\@openstack.org</a>.  You may also provide us with a direct link to your docs.</p>

        <h4 class='head'>Starting a New Extensions Document</h4>
        <p>Although you can use any format, using our <a href='https://github.com/RackerWilliams/extension-doc-templates/tree/master/docbook'>DocBook template</a> ensures your document will merge seamlessly into the documentation system. There is also an <a href="https://github.com/RackerWilliams/extension-doc-templates/tree/master/rst">RST template</a> available. You can find the <a href="https://github.com/RackerWilliams/extension-doc-templates">templates</a> on GitHub.
        </p>
    </div>
    </div>
    </body>
</html>
<!-- The extension directory was last scanned at $last_update_txt. -->
EOT
