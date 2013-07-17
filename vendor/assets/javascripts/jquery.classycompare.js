/*!
 * jQuery ClassyCompare
 * http://www.class.pm/projects/jquery/classycompare
 *
 * Written by Marius Stanciu - Sergiu <marius@picozu.com>
 * Licensed under the GPL Version 3 license.
 * Version 1.1.1
 *
 */
(function ($) {
    $.fn.extend({
        ClassyCompare: function (b) {
            var c = {
                defaultgap: 50,
                leftgap: 10,
                rightgap: 10,
                caption: false,
                reveal: .5
            };
            var b = $.extend(c, b);
            return this.each(function () {
                var c = b, h = $(this).children("img:eq(0)").width(), i = $(this).children("img:eq(0)").height();
                $(this).css("height",i);
                $(this).css("width",h);
                $(this).children("img").hide();
                $(this).css({
                    overflow: "hidden",
                    position: "relative"
                });
                $(this).append('<div class="uc-mask"></div>');
                $(this).append('<div class="uc-bg"></div>');
                $(this).append('<div class="uc-caption">' + $(this).children("img:eq(0)").attr("alt") + "</div>");
                $(this).children(".uc-mask, .uc-bg").width(h);
                $(this).children(".uc-mask, .uc-bg").height(i);
                $(this).children(".uc-mask").animate({
                    width: h - c.defaultgap
                }, 1e3);
                $(this).children(".uc-mask").css("backgroundImage", "url(" + $(this).children("img:eq(0)").attr("src") + ")");
                $(this).children(".uc-bg").css("backgroundImage", "url(" + $(this).children("img:eq(1)").attr("src") + ")");
                if (c.caption) {
                    $(this).children(".uc-caption").show();
                }
            }).mousemove(function (c) {
                var d = b;
                var pos_img = $(this).position()["left"];
                var new_width = c.pageX - pos_img;
                var img_width = $(this).width();
                var img_cap_one = $(this).children("img:eq(0)").attr("alt");
                var img_cap_two = $(this).children("img:eq(1)").attr("alt");
                if (new_width > d.leftgap && new_width < img_width - d.rightgap) {
                    $(this).children(".uc-mask").width(new_width)
                }
                if (new_width < img_width * d.reveal) {
                    $(this).children(".uc-caption").html(img_cap_two)
                }
                else {
                    $(this).children(".uc-caption").html(img_cap_one)
                }
            })
        }
    })
})(jQuery)
