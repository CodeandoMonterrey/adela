$ ->
  $("#view_more").on("click", (e) ->
    e.preventDefault()
    $(".more-activities").removeClass("hidden")
    $(this).addClass("hidden")
  )

  $("#view_less").on("click", (e) ->
    e.preventDefault()
    $(".more-activities").addClass("hidden")
    $(this).addClass("hidden")
    $("#view_more").removeClass("hidden")
  )

  $(document).on("pjax:timeout", () ->
    false
  )

  $("#calendar").on("pjax:start", () ->
    spinner = new Spinner({color:'#999999', lines: 11, width: 3}).spin()
    $("#calendar-header").html("")
    $("#calendar-content").html(spinner.el)
  )

  $("#organizations").on("pjax:start", () ->
    spinner = new Spinner({color:'#999999', lines: 11, width: 3}).spin()
    $("#organizations").html(spinner.el)
  )

  $("#catalogs").on("pjax:start", () ->
    spinner = new Spinner({color:'#999999', lines: 11, width: 3}).spin()
    $("#catalogs").html(spinner.el)
  )

  $("form.search").submit (e) ->
    $.pjax({
      url: this.action + '?' + $(this).serialize(),
      container: '#organizations'
    })
    false

  $(document).pjax(".calendar-nav-bar a, a.calendar-navigation-link", '[data-pjax-container]')
  $(document).pjax("#organizations_links .pagination a", '#organizations')
  $(document).pjax("#catalogs_links .pagination a", '#catalogs')