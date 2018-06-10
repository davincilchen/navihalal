document.addEventListener("turbolinks:load", function () {
  $input = $("[data-behavior='autocomplete']")

  var options = {
    getValue: "name",
    url: function (phrase) {
      return "/search.json?q=" + phrase;
    },
    categories: [
      {
        listLocation: "restaurants",
        header: "<strong></strong>",
      },
      {
        listLocation: "tags",
        header: "<strong></strong>",
      },
      {
        listLocation: "users",
        header: "<strong></strong>",
      }
    ],
    list: {
      onChooseEvent: function () {
        var url = $input.getSelectedItemData().url
        $input.val("")
        Turbolinks.visit(url)
      }
    }
  }

  $input.easyAutocomplete(options)
});
