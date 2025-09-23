<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!DOCTYPE html> 
    <html>
	<head> 
		<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&display=swap" rel="stylesheet">
		<link rel="stylesheet" href="css/index.css">
        <link rel="stylesheet" href="css/media.css">
		<title>First Assignment</title>
	</head>
	<body>
        <div class="main-container">
            <header>
                <span class="logo">
                    <img src="images/table.jpg" />
                </span>
            
                <div class="nav-container">
                    <div class="nav-row">
                        <a href="">Link 1</a> |
                        <a href="">Link 2</a> |
                        <a href="">Link 3</a> |
                        <a href="">Link 4</a> |
                        <a href="">Link 5</a> |
                        <a href="">Link 6</a> |
                        <a href="">Link 7</a>
                        <div class="search-container">
                            <input type="text" placeholder="Search.." name="search">
                            <button type="submit">
                                <i class="fa fa-search"></i>
                            </button>
                        </div>
                    </div>
    
                    <div class="nav-row second-links" style="margin-top: 5px">
                        <a href="">Link 1</a> |
                        <a href="">Link 2</a> |
                        <a href="">Link 3</a> |
                        <a href="">Link 4</a> |
                        <a href="">Link 5</a> |
                        <a href="">Link 6</a> |
                        <a href="">Link 7</a> |
                        <a href="">Link 8</a> |
                        <a href="">Link 9</a>
                    </div>
                </div>
                
            </header>

            <!-- SLIDESHOW -->
            <div class="row1">
                <div class="gallery-container">
                    <div class="news active" style="background-image: url('images/banJunkFood.jpg')">
                        <div class="news-content">
                            <div class="text-container">
                                <span class="stackedtext top-text" style="margin-left: 10px">Ban on junk food!</span>
                                <span class="stackedtext bottom-text" style="margin: 0 0 10px 10px">Council says yes to ban on junk food ads.</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="news" style="background-image: url('images/salt.jpg')">
                        <div class="news-content">
                            <div class="text-container">
                                <span class="stackedtext top-text" style="margin-left: 10px">Eating enough salt?</span>
                                <span class="stackedtext bottom-text" style="margin: 0 0 10px 10px">Some are eating too much, some not enough.</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="news" style="background-image: url('images/setTable.jpg')">
                        <div class="news-content">
                            <div class="text-container">
                                <span class="stackedtext top-text" style="margin-left: 10px">Sleep better!</span>
                                <span class="stackedtext bottom-text" style="margin: 0 0 10px 10px">List of foods that surprisingly lead to better sleep.</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="indicators">
                        <div class="indicator active" data-index="0"></div>
                        <div class="indicator" data-index="1"></div>
                        <div class="indicator" data-index="2"></div>
                    </div>
                </div>
            </div>

            <!-- SECOND ROW -->
            <!-- BULLETED LIST -->
            <div class="row2-box1 card">
                <h3>International food holidays</h3>
                <hr>
                <ul>
                    <li>World pizza day - 9th February</li>
                    <li>International sushi day - 18th June</li>
                    <li>World pasta day - 25th October</li>
                    <li>National taco day - 4th October</li>
                    <li>World chocolate day - 7th July</li>
                    <li>International coffee day - 1st October</li>
                </ul>
                <div class="card-footer">
                    <a href="#">Link 1</a>
                    <a href="#">Link 2</a>
                </div>
            </div>

            <!-- BOX WITH HOVER -->
            <div class="row2-box2 whitebox">
                <div class="hover-trigger-container">
                    <div class="default">
                        <img src="images/pancakesWide.jpg">
                        <div class="text-container">
                            <span class="stackedtext top-text">
                                Eat healthy!
                            </span>
                            <span class="stackedtext bottom-text">
                                Choose a healthy breakfast option.
                            </span>
                        </div>
                    </div>
                    <div class="hover-content">
                        <p>
                            <strong>Breakfast is important:</strong><br>
                            A healthy breakfast is important because it gives your body the energy and nutrients it needs to 
                            start the day, helps improve focus and concentration, and supports overall health by boosting 
                            metabolism and balancing blood sugar levels.
                        </p>
                    </div>
                </div>
            </div>

            <!-- IMAGE AND CARD -->
            <div class="row2-wide">
                <div class="midbox">
                    <img src="images/pasta.jpg">
                </div>
                <div class="midbox card">
                    <h2> Dark Chocolate Benefits </h2>
                    <div class="card-scrollable">
                        <p> Dark chocolate can help lower blood pressure and reduce inflammation. 
                            A study of an isolated tribe with high intakes of cocoa had lower rates of heart disease, 
                            cancer and diabetes compared to the same tribesmen who had migrated to cities. 
                        </p>
                        <div class="rightcard-footer">
                            <a href=""> Link 1 </a>
                            <br/>
                            <a href=""> Link 2 </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- THIRD ROW -->
            <!-- PLAYABLE VIDEO -->
            <div class="row3-box1 whitebox">
                <video src="videos/foodVideo.mp4#t=0.1" controls="controls" preload="metadata" onclick="this.play();arguments[0].preventDefault();"></video>
            </div>

            <div class="row3-wide">
                <img src="images/bowlWide.jpg">
            </div>

            <!-- TWITTER FEED -->
            <div class="row3-box2 whitebox">
                <script type="text/javascript" src="https://feed.mikle.com/js/fw-loader.js" preloader-text="Loading" data-fw-param="175206/"></script> <!-- end feedwind code -->
            </div>
        </div>

        <!-- JS -->
        <script>
            // JS for rotating news
            document.addEventListener('DOMContentLoaded', function() {
                const allNews = document.querySelectorAll('.news');
                const indicators = document.querySelectorAll('.indicator');
                let currentnews = 0;
                function shownews(index) {
                    allNews.forEach(news => news.classList.remove('active'));
                    indicators.forEach(indicator => indicator.classList.remove('active'));
                    allNews[index].classList.add('active');
                    indicators[index].classList.add('active');
                    currentnews = index;
                }
                function nextNews() {
                    let nextIndex = (currentnews + 1) % allNews.length;
                    shownews(nextIndex);
                }
                setInterval(nextNews, 5000);
                indicators.forEach(indicator => {
                    indicator.addEventListener('click', function() {
                        let newsIndex = parseInt(this.getAttribute('data-index'));
                        shownews(newsIndex);
                    });
                });
            });

            // JS for hover effect
            document.querySelectorAll('.hover-trigger-container').forEach(function(hoverContainer) {
                const bottomText = hoverContainer.querySelector('.bottom-text');
                const hoverContent = hoverContainer.querySelector('.hover-content');
                const defaultContent = hoverContainer.querySelector('.default');
                if (bottomText && hoverContent && defaultContent) {
                    function showHover() {
                        hoverContent.style.opacity = '1';
                        hoverContent.style.visibility = 'visible';
                        defaultContent.style.opacity = '0';
                    }
                    function hideHover() {
                        hoverContent.style.opacity = '0';
                        hoverContent.style.visibility = 'hidden';
                        defaultContent.style.opacity = '1';
                    }
                    bottomText.addEventListener('mouseenter', function() {
                        showHover();
                    });
                    bottomText.addEventListener('mouseleave', function(e) {
                        if (hoverContent.contains(e.relatedTarget)) return;
                        hideHover();
                    });
                    hoverContent.addEventListener('mouseenter', function() {
                        showHover();
                    });
                    hoverContent.addEventListener('mouseleave', function(e) {
                        if (bottomText.contains(e.relatedTarget)) return;
                        hideHover();
                    });
                }
            });    
        </script>
	</body>
</html>

</asp:Content>
