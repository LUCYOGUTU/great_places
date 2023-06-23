const GOOGLE_MAPS_API_KEY = 'AIzaSyDK3hsR5MEX4hhkBfgtei8cLPryah8Ye88';
// const GOOGLE_MAPS_API_PLATFORM_KEY = 'AIzaSyBrG2H46qHhLR_oQwO5C0sIAOjIAUmgg5U';

class LocationHelper {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude, $longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_MAPS_API_KEY';
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude, $longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_MAPS_API_KEY&signature=YOUR_SIGNATURE';
  }
}
