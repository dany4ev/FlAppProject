<%@ Page Language="C#" %>

<!DOCTYPE html>
<script type="text/C#" runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        rptMasonry.DataSource = MasonryApp.Models.ProductRepository.GetData(1, 25);
        rptMasonry.DataBind();
    }

    [System.Web.Services.WebMethod]
    public static IEnumerable<MasonryApp.Models.Product> GetData(int pageNo, int pageSize)
    {
        return MasonryApp.Models.ProductRepository.GetData(pageNo, pageSize);
    }
    
</script>
<html>
<head runat="server">
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <title>Pinterest Like Layout</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
    <link type="text/css" rel="stylesheet" href="Content/Site.css" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/masonry.pkgd.min.js"></script>
    <script src="Scripts/imagesloaded.min.js"></script>
</head>
<body>
    <form id="HtmlForm" runat="server">
        <div class="container body-content">

            <div id="container" class="transitions-enabled infinite-scroll clearfix">
                <asp:Repeater ID="rptMasonry" runat="server">
                    <ItemTemplate>
                        <div class="box">
                            <a href="#" class="">
                                <img src="<%# Eval("Url") %>" /></a>
                            <p><%# Eval("Description") %></p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div id="imgLoad">
                <img src="http://i.imgur.com/6RMhx.gif" />
            </div>

            <script type="text/javascript">
                $(function () {

                    var $container = $('#container');

                    $container.imagesLoaded(function () {
                        $container.masonry({
                            itemSelector: '.box',
                            columnWidth: 100,
                            isAnimated: true
                        });
                    });

                });

                var pageNo = 1, pageSize = 25;

                function loadMore() {

                    var $container = $('#container');

                    $('#imgLoad').show();

                    $.ajax({
                        type: "POST",
                        url: "PintrestLikeApp.aspx/GetData",
                        data: JSON.stringify({ pageNo: pageNo + 1, pageSize: pageSize }),
                        dataType: "json",
                        contentType: "application/json",
                        complete: function (response) {
                            console.log("Response: " + response);
                            $('#imgLoad').hide();
                        },
                        success: function (response) {
                            if (response.d.length > 0) {
                                var ctrls = [];
                                for (var i = 0; i < response.d.length; i++) {
                                    ctrls.push('<div class="box"><a href="#" class=""><img src="' + response.d[i].Url + '" /></a><p>' + response.d[i].Description + '</p></div>');
                                }
                                var $newElems = $(ctrls.join(''));
                                $container.append($newElems);
                                $newElems.css({ opacity: 0 });
                                $newElems.imagesLoaded(function () {
                                    // show elems now they're ready
                                    $newElems.css({ opacity: 1 });
                                    $container.masonry('appended', $newElems, true);
                                });
                                pageNo++;
                            }
                        }
                    });
                }

                $(window).scroll(function () {

                    if ($(window).scrollTop() === $(document).height() - $(window).height() && !($('#imgLoad').is(':visible'))) {
                        loadMore();
                    }
                });
            </script>

            <hr />
            <footer>
                <p>&copy; <%: DateTime.Now.Year %> - My ASP.NET Application</p>
            </footer>
        </div>
    </form>
</body>
</html>
