import 'package:dio/dio.dart';
import 'package:pinpoint/model/notes/notes.dart';
import 'package:pinpoint/resources/constant/string/appString.dart';
import 'package:retrofit/retrofit.dart';

part 'note_service.g.dart';

@RestApi(baseUrl: "${AppString.baseUrl}")
abstract class NoteService {
  factory NoteService(Dio dio, {String baseUrl}) = _NoteService;

  @GET("/notes")
  Future<List<Note>> getAllNotes(
  );

  @GET("/notes/{id}")
  Future<Note> getNoteById(
    @Path("id") String id,
  );

  @POST("/notes")
  Future<Note> createNote(
    @Body() Note note,
  );

  @PUT("/notes")
  Future<HttpResponse> updateNote(
    @Body() Note note,
  );

  @DELETE("/notes/{id}")
  Future<HttpResponse> deleteNote(
    @Path("id") String id,
  );
}
