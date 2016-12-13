do(exports = @) ->
    class Query
        constructor: (@column, @message, @dataType) ->
            @updatedList = []

        isShowPurpose_: ->
            return @dataType is DATATYPE_NEW_CHANNEL or @dataType is DATATYPE_PURPOSE

        isShowTopic_: ->
            return @dataType is DATATYPE_NEW_CHANNEL or @dataType is DATATYPE_TOPIC

        createMessage: (excludes = null) ->
            text = @message
            for channel in @updatedList
                if excludes and excludes.findIndex(channel.name) isnt -1
                    continue
                text = "#{text}\n##{channel.name}"
                text = "#{text} #{channel.purpose.value}" if @isShowPurpose_()
                text = "#{text} #{channel.topic.value}" if @isShowTopic_()
            return text

        compare: (baseList, index, channel) ->
            switch @dataType
                when DATATYPE_NEW_CHANNEL
                    return baseList.findChannelName channel.name
                when DATATYPE_PURPOSE
                    return baseList[index].purpose.last_set isnt channel.purpose.last_set
                when DATATYPE_TOPIC
                    return baseList[index].topic.last_set isnt channel.topic.last_set
                when DATATYPE_ARCHIVE
                    return not channel.is_archived and channel.num_members is 0

    exports.Query = Query
