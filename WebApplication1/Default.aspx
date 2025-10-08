<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

        <div class="main-container">
            <header>
                <span class="logo">
                    <img src="https://cdn.mos.cms.futurecdn.net/JAa8rg6avnznk7WXqLS8sQ-840-80.jpg.webp" />
                </span>
            
                <div class="nav-container">
                    <div class="nav-row"> 
                        <a href="">Link 1</a> |
                        <a href="">Link 2</a> |
                        <a href="">Link 3</a> |
                        <a href="">Link 4</a> |
                        <a href="">Link 5</a> |
                        <a href="">Link 6</a> |
                        <asp:LinkButton ID="AdminLinkButton" runat="server" OnClick="AdminLink_Click"></asp:LinkButton>
                  
                        <div class="search-container">
                            <form id="searchForm">
                                <input type="text" id="searchBox" placeholder="Search..." autocomplete="off" />
                                <div id="searchResults" class="search-results"></div>
                            </form>
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

            <div class="row1">
                <div class="gallery-container">
                    <asp:Repeater ID="rptSlides" runat="server">
                        <ItemTemplate>
                           <div class="news <%# Container.ItemIndex == 0 ? "active" : "" %>" style="background-image: url('<%# ResolveUrl(Eval("imgurl").ToString()) %>')">
                                <div class="news-content">
                                    <div class="text-container">
                                        <span class="stackedtext top-text" style="margin-left: 10px"><%# Eval("title") %></span>
                                        <span class="stackedtext bottom-text" style="margin: 0 0 10px 10px"><%# Eval("contents") %></span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <div class="indicators">
                        <asp:Repeater ID="rptIndicators" runat="server">
                            <ItemTemplate>
                                <div class="indicator <%# Container.ItemIndex == 0 ? "active" : "" %>" data-index="<%# Container.ItemIndex %>"></div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>

            <!-- SECOND ROW -->
            <!-- BULLETED LIST -->

            <div class="row2-box1 card">
                <h3>Latest News</h3>
                <hr>
                <ul>
                    <% if (ListNews != null && ListNews.Count > 0) { %>
                        <% foreach(var newsItem in ListNews) { %>
                            <li><%= newsItem.title %> - <%= newsItem.contents.Length > 50 ? newsItem.contents.Substring(0, 50) + "..." : newsItem.contents %></li>
                        <% } %>
                    <% } else { %>
                        <li>No news items available</li>
                    <% } %>
                </ul>
                <div class="card-footer">
                    <a href="https://www.space.com/">View More</a>
                    <a href="#">Link</a>
                </div>
            </div>

            <!-- BOX WITH HOVER -->

            <div class="row2-box2 whitebox">
                <div class="hover-trigger-container">
                    <div class="default">
                        <img src="<%= !string.IsNullOrEmpty(HoverNews?.imgurl) ? ResolveUrl(HoverNews.imgurl) : "images/pancakesWide.jpg" %>">
                        <div class="text-container">
                            <span class="stackedtext top-text">
                                <%= HoverNews?.title ?? "No Title" %>
                            </span>
                            <span class="stackedtext bottom-text">
                                Hover to read more
                            </span>
                        </div>
                    </div>
                    <div class="hover-content">
                        <p>
                            <strong><%= HoverNews?.title ?? "No Title" %>:</strong><br>
                            <%= HoverNews?.contents ?? "No contents available" %>
                        </p>
                    </div>
                </div>
            </div>

            <!-- IMAGE AND CARD -->

            <div class="row2-wide">
                <div class="midbox">
                    <img src="<%= !string.IsNullOrEmpty(MidBoxNews?.imgurl) ? ResolveUrl(MidBoxNews.imgurl) : "images/pasta.jpg" %>">
                </div>
                <div class="midbox card">
                    <h2><%= MidBoxNews?.title ?? "No Title" %></h2>
                    <div class="card-scrollable">
                        <p><%= MidBoxNews?.contents ?? "No contents available" %></p>
                        <div class="rightcard-footer">
                            <a href="#">Link 1</a>
                            <br/>
                            <a href="#">Link 2</a>
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
                <img src="<%= !string.IsNullOrEmpty(Row3WideNews?.imgurl) ? ResolveUrl(Row3WideNews.imgurl) : "images/bowlWide.jpg" %>">
                <div class="text-container">
                    <span class="stackedtext top-text">
                        <%= Row3WideNews?.title ?? "No Title" %>
                    </span>
                    <span class="stackedtext bottom-text">
                        <%= Row3WideNews?.contents?.Length > 60 ? Row3WideNews.contents.Substring(0, 60) + "..." : Row3WideNews?.contents ?? "No contents available" %>
                    </span>
                </div>
            </div>
           
            <div class="row3-box2 whitebox">
                <script type="text/javascript" src="https://feed.mikle.com/js/fw-loader.js" preloader-text="Loading" data-fw-param="175419/"></script>
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

            //search
            document.addEventListener('DOMContentLoaded', function () {
                const searchBox = document.getElementById("searchBox");
                const searchResults = document.getElementById("searchResults");
                let timer;

                console.log("Search initialized", searchBox, searchResults);

                searchResults.innerHTML = "";
                searchResults.style.display = "none";

                searchBox.addEventListener("keyup", function () {
                    clearTimeout(timer);
                    const query = this.value.trim();

                    console.log("Search query:", query);

                    if (query.length === 0) {
                        searchResults.innerHTML = "";
                        searchResults.style.display = "none";
                        return;
                    }

                    searchResults.innerHTML = "<div style='padding: 8px; background: white; color: black;'>Searching...</div>";
                    searchResults.style.display = "block";

                    //debounce
                    timer = setTimeout(() => {
                        console.log("Fetching results for:", query);

                        fetch("SearchHandler.ashx?q=" + encodeURIComponent(query))
                            .then(response => {
                                console.log("Response status:", response.status);
                                return response.json();
                            })
                            .then(data => {
                                console.log("Data received:", data);
                                searchResults.innerHTML = "";

                                if (!data || data.length === 0) {
                                    searchResults.innerHTML = "<div style='padding: 8px; background: white; color: black; border: 1px solid red;'>No results found</div>";
                                    searchResults.style.display = "block";
                                    return;
                                }

                                data.forEach(item => {
                                    const div = document.createElement("div");
                                    div.textContent = item.title;
                                    div.style.padding = "8px";
                                    div.style.background = "white";
                                    div.style.color = "black";
                                    div.style.cursor = "pointer";
                                    div.style.borderBottom = "1px solid #ccc";
                                    div.onclick = () => window.location.href = "NewsDetails.aspx?ID=" + item.id;
                                    div.onmouseover = () => div.style.background = "#f0f0f0";
                                    div.onmouseout = () => div.style.background = "white";
                                    searchResults.appendChild(div);
                                });
                                searchResults.style.display = "block";
                                console.log("Results appended, display:", searchResults.style.display);
                            })
                            .catch(err => {
                                console.error("Search error:", err);
                                searchResults.innerHTML = "<div style='padding: 8px; background: red; color: white;'>Error: " + err.message + "</div>";
                                searchResults.style.display = "block";
                            });
                    }, 300);
                });

                document.addEventListener("click", function (e) {
                    if (!searchBox.contains(e.target) && !searchResults.contains(e.target)) {
                        searchResults.innerHTML = "";
                        searchResults.style.display = "none";
                    }
                });

                //enter was doing something weird 
                searchBox.addEventListener("keydown", function (e) {
                    if (e.key === "Enter") {
                        e.preventDefault(); 
                    }
                });
            });

          


        </script>

</asp:Content>
