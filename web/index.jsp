<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title></title>
      <style>
        #pageWrapper{
            position: relative;
            top: 100px;
            width: 1000px;
            margin: 0 auto;
        }
        #modalWindow{
            width:1000px;
            font-size: 14px;
        }
        #modalWindowButton{
            border: 2px solid lightblue;
            width: 50px;
            border-radius: 13px;
            text-align: center;
            background: lightblue;
            cursor: pointer;
        }
        #modalWindowButton:hover{
            border: 2px solid lightcyan;
        }
      </style>
      <link rel="stylesheet" href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">
      <script src="//code.jquery.com/jquery-1.10.2.js"></script>
      <script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
      <script src="i18n.js"></script>


  </head>
  <body>
    <div id="pageWrapper">
        <div id="mainTxt">
            This demo provides menus localization via specified json files containing unified to other languages translations. Hope, you'll enjoy it.
        </div>
        <hr>
        <div id="modalWindowButton">Demo</div>
    </div>

    <div id="modalWindow" hidden i18ntitle="helpTitle">
        <select id="modalWindowLanguageSelector">
            <option value="en">Eng</option>
            <option value="ru">Ru</option>
        </select>
        <span id="changeLanguageTimesYou" i18n="youHaveChanged"></span>
        <span id="changeLanguageTimesCount" i18nt="%n times"></span>
        <span id="changeLanguageTimesVerb" i18n="haveChangedText"></span>
        <hr>
        <div id="helpMsg" i18n="helpText"></div>
    </div>
    <script type="text/javascript">
        var langChangedTimes = -1;
        var openedOnce = false;
        $("#modalWindowButton").click(function(){
            $("#modalWindow").dialog({
                       width: 1000,
                       open: function(){
                           if (!openedOnce){
                               $("#modalWindowLanguageSelector").change();
                               openedOnce = true;
                           }

                       }
            });

        })

        $("#modalWindowLanguageSelector").change(function(){
            langChangedTimes++;
            var ajaxUrl = $(this).val()=="en" ? "/translate_en.json" : "/translate_ru.json";
            $.ajax(ajaxUrl).done(function(text){
                i18n.add(text);

                $("#modalWindow").dialog("option","title",i18n($("[i18ntitle]").attr("i18ntitle")));

                $.each($("[i18n]"),function(i,o){
                        $(o).html(i18n($(o).attr("i18n")));
                })
                $.each($("[i18nt]"),function(i,o){
                    $(o).html(i18n($(o).attr("i18nt"),langChangedTimes));
                })
            })
        });

    </script>
  </body>
</html>