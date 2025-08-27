import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/src/domain/const/const.dart';
import 'package:mxc_logic/src/domain/entities/ai/ai.dart';
import 'package:mxc_logic/src/domain/entities/chains_list/chains_list.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web3dart/web3dart.dart';

class ChatRepository {
  ChatRepository(
    this._web3Client,
  ) : _restClient = RestClient();

  final Web3Client _web3Client;
  final RestClient _restClient;

  Future<String> newConversation(String walletAddress) async {
    final response = await _restClient.client.get(
      Uri.parse(
        Urls.newConversation(walletAddress),
      ),
      headers: Urls.aiHeader,
    );

    final newConversationResponse =
        AiNewConversationResponse.fromJson(response.body);
    if (newConversationResponse.retcode == null ||
        newConversationResponse.retcode != 0 ||
        newConversationResponse.data == null ||
        newConversationResponse.data?.id == null) {
      throw 'unable_to_create_new_conversation';
    }
    return newConversationResponse.data!.id!;
  }

  Stream<String> sendMessage(
    String conversationId,
    List<AIMessage> messages,
    String myName,
  ) async* {
    Request request = Request(
      'POST',
      Uri.parse(
        Urls.completion,
      ),
    );
    request.headers.addAll(Urls.aiHeaderWithStream());
    // Append message history
    request.body = jsonEncode(
      AiCompletionRequestBody(
        conversationId: conversationId,
        messages: messages,
        myname: myName,
        quote: false,
      ).toJson(),
    );

    final streamedResponse = await _restClient.client.send(
      request,
    );

    if (streamedResponse.statusCode == 200) {
      await for (var line in streamedResponse.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())) {
        if (line.startsWith('data:')) {
          final jsonStr = line.substring(5).trim();
          if (jsonStr.isNotEmpty) {
            try {
              final map = json.decode(jsonStr) as Map<String, dynamic>;
              if (map['data'] is bool) {
                return;
              }
              final data = AiCompletionResponse.fromMap(map);

              if (data.retcode == null || data.retcode != 0 || data.data == null || data.data?.id == null || data.data?.answer == null )  {
                throw 'unable_to_send_new_message';
              }

              yield data.data!.answer!;

            } catch (e) {
              // Skip malformed JSON
              throw 'unable_to_send_new_message';
            }
          }
        }
      }
    } else {
      throw 'unable_to_send_new_message';
    }
  }
}
