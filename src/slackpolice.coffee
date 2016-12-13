do(exports = @) ->
    class SlackPolice
        constructor: (@sheet, @token) ->
            @debug = false
            @channel = null
            @username = null
            @iconEmoji = null
            @api = new Slack(@token)
            @police = new Police(@sheet)
            @asUser = false

        setDebug: (debug) ->
            @debug = debug
            @api.setDebug debug
            return @

        setAsUser: (asUser) ->
            @asUser = asUser
            @api.setAsUser asUser
            return @

        setChannel: (channel) ->
            @channel = channel
            return @

        setUsername: (username) ->
            @username = username
            return @

        setIconEmoji: (iconEmoji) ->
            @iconEmoji = iconEmoji
            return @

        addDataType: (column, message, dataType) ->
            @police.addDataType column, message, dataType
            return @

        patrol: (excludeSheet = null, excludeSheetRowFirstIndex = 1) ->
            channels = @api.channelsList().channels
            queries = @police.patrol channels
            @showMessages_ queries, channels, excludeSheet, excludeSheetRowFirstIndex
            return true

        showMessages_: (queries, channels, excludeSheet, excludeSheetRowFirstIndex) ->
            for query in queries
                if query.updatedList.length > 0 and query.updatedList.length isnt channels.length
                    @showMessage_ query
            return @

        showMessage_: (query, excludeSheet, excludeSheetRowFirstIndex) ->
            excludes = @excludeList_(excludeSheet, excludeSheetRowFirstIndex, query.column) if excludeSheet
            message = query.createMessage(excludes)
            if message isnt query.message
                @api.chatPost message, @channel, @username, @iconEmoji
            return @

        excludeList_: (sheet, row, column) ->
            sheet.getRange(row, column, sheet.getLastRow()).getValues()

    exports.SlackPolice = SlackPolice
