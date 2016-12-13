do(exports = @) ->
    class Police
        constructor: (@sheet) ->
            @queries = []
            @baseList = []

        addDataType: (column, message, dataType) ->
            @queries.push new Query column, message, dataType
            return @

        patrol: (channels, excludes) ->
            @init_()
            @checkChannels_(channels)
            return @queries

        init_: ->
            for json in @sheet.getRange(1,1, if @sheet.getLastRow() isnt 0 then @sheet.getLastRow() else 1).getValues()
                try
                    @baseList.push JSON.parse(json)
                catch ignore
            @sheet.clear()

        checkChannels_: (channels) ->
            for channel, row in channels
                if channel.is_channel
                    @checkChannel_ channel, row

        checkChannel_: (channel, row) ->
            index = -1
            newChannel = @getQuery_ DATATYPE_NEW_CHANNEL
            index = if newChannel then newChannel.compare(@baseList, 0, channel) else -1
            if index isnt -1
                for dataType in [DATATYPE_PURPOSE, DATATYPE_TOPIC, DATATYPE_ARCHIVE]
                  query = @getQuery_ dataType
                  query.updatedList.push(channel) if query and query.compare(@baseList, index, channel)
            else
                newChannel.updatedList.push channel
            @save_ row + 1, 1, channel

        getQuery_: (dataType) ->
            for query in @queries
                if query.dataType is dataType
                    return query

        save_: (row, column, value) ->
            @sheet.getRange(row, column).setValue(JSON.stringify(value))

    exports.Police = Police
