path = require 'path-extra'
{$, $$, _, React, ReactBootstrap, ROOT} = window
{OverlayTrigger, Tooltip} = ReactBootstrap
{SlotitemIcon} = require '../../../etc/icon'
getBackgroundStyle = ->
  if window.isDarkTheme
    backgroundColor: 'rgba(33, 33, 33, 0.7)'
  else
    backgroundColor: 'rgba(256, 256, 256, 0.7)'
Slotitems = React.createClass
  render: ->
    <div className="slotitems">
    {
      {_slotitems} = window
      for itemId, i in @props.slot.concat(@props.slot_ex || 0)
        continue unless (i < @props.slot_num) or (i == 5 and itemId != 0)
        item = _slotitems[itemId] || {api_name: "", api_type: [0, 0, 0, 0]}
        isExist = _slotitems[itemId]?

        itemOverlay = if isExist
          <Tooltip id="fleet-#{@props.fleet}-slot-#{@props.key}-item-#{i}-level">
            {i18n.resources.__ item.api_name}
            {
              if item.api_level? and item.api_level > 0
                <strong style={color: '#45A9A5'}> ★{item.api_level}</strong>
            }
            {
              if item.api_alv? and 1 <= item.api_alv <= 7
                <img className='alv-img' src={path.join('assets', 'img', 'airplane', "alv#{item.api_alv}.png")} />
            }
          </Tooltip>

        itemSpan =
          <span>
            <SlotitemIcon key={itemId} className='slotitem-img' slotitemId={item.api_type[3]} />
            <span className="slotitem-onslot
                            #{if (i == 5) or (item.api_type[3] == 0) or (6 <= item.api_type[3] <= 10) or (21 <= item.api_type[3] <= 22) or (item.api_type[3] == 33) then 'show' else 'hide'}
                            #{if @props.onslot[i] < @props.maxeq[i] then 'text-warning'}"
                            style={getBackgroundStyle()}>
              {if i == 5 then "+" else @props.onslot[i]}
            </span>
          </span>

        <div key={i} className="slotitem-container">
        {
          if itemOverlay
            <OverlayTrigger placement='left' overlay={itemOverlay}>
              {itemSpan}
            </OverlayTrigger>
          else
            itemSpan
        }
        </div>
    }
    </div>

module.exports = Slotitems
