class Yastapp
  constructor : (@context) ->
  tasks : []

  addTask : (taskName) ->
    task = new Task taskName, @context
    receiver = $('.tasklist', @context)
    receiver.append task.generateHtml()
    task.display()
    @tasks.push task

    return task.identifier

class Task
  constructor : (@task, @context) ->
    @identifier = @generateIdentifier()
    htmlElement = $('p', "##{@identifier}")
    self = this

    @context.on 'dblclick', "##{@identifier}", (event) ->
      newValue = prompt 'New value'
      self.update newValue

  toString : ->
    @task

  generateHtml : ->
    "<div id=\"#{@identifier}\" style=\"display: none\">#{@generateInnerHtml()}</div>"

  generateInnerHtml : ->
    "<input type=\"checkbox\" style=\"float: left; width: 20px;\" /> 
      &nbsp;
      <p style=\"float: left\">#{@toString()}</p>
      <div style=\"clear: both\"></div>"

  generateEditHtml : ->
    "<input type=\"text\" value=\"#{@toString()}\" />"

  generateIdentifier : ->
    identifier = "yastask-"
    identifier += Math.floor(Math.random() * (9 - 1 + 1)) + 1 for i in [0..8]

    return identifier

  update : (newValue) ->
    self = this
    return false if !newValue
    @task = newValue
    element = $('p', "##{@identifier}")
    element.animate { opacity: 0 }, 250, ->
      element.html self.task
      element.animate { opacity: 1 }, 250

  display : ->
    $("##{@identifier}").slideDown()


currentStep = 0
yastapp = new Yastapp $('.yatapi-tasks')
$addTaskInput = $ '.yatapi-tasks .yatapi-addtask-input'

stepOne = ->
  currentStep++
  $('.yatapi-addtask-input').focus()

stepTwo = ->
  currentStep++
  $('#tour-guide').fadeOut ->
    $(this).text('Well done!')
    $(this).fadeIn ->
      setTimeout(->
        $('#tour-guide').fadeOut()
        yastapp.addTask "Now try to edit a task double clicking on it"
      , 1500)
  $('.tasklist').fadeIn()

stepOne()

$addTaskInput = $ '.yatapi-tasks .yatapi-addtask-input'
$addTaskInput.on 'keypress', (event) ->
  if event.charCode is 13
    value = $(this).val()
    return false if !value
    $(this).val('')
    yastapp.addTask value

    if currentStep is 1
      stepTwo()
