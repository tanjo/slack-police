do(exports = @) ->
    class Slack
        constructor: (@token) ->
            @BASE_URL = "https://slack.com"
            @API_ENDPOINT = "#{@BASE_URL}/api/"
            @debug = false
            @asUser = false

        setDebug: (debug) ->
            @debug = debug
            return @

        setAsUser: (asUser) ->
            @asUser = asUser
            return @

        chatPost: (text, channel = null, username = null, iconEmoji = null) ->
            if @debug or not channel
                Logger.log text
            else
                payload =
                    channel: channel
                    text: text
                    parse: "full"
                if @asUser
                    payload.as_user = @asUser
                else
                    payload.username = if username then username else "Slack警察"
                    payload.icon_emoji = if iconEmoji then iconEmoji else ":cop:"
                @request_("chat.postMessage", payload)

        channelsList: ->
            @request_("channels.list")

        request_: (resource, payload = {}) ->
            payload.token = @token
            params =
                method: "POST"
                payload: payload
            response = UrlFetchApp.fetch "#{@API_ENDPOINT}#{resource}", params
            return JSON.parse(response.getContentText())

    exports.Slack = Slack
