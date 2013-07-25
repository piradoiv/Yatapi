
$yColumnsToday = $ '.yatapi-tasks .yatapi-today-list'

$addTaskInput = $ '.yatapi-tasks .yatapi-addtask-input'
$addTaskInput.on 'keypress', (event) ->
  if event.charCode is 13
    value = $(this).val()
    $(this).val('')
    $yColumnsToday.append "<p>#{value}</p>"
