/// [LoadingStatus] state management te kullanılan yüklenme durumları.
/// [ApiStatus] Api den gelen status durumları.
/// [BaseModelStatus] BL katmanı ile Controleller katmanı arasındaki (HttpStatus) API Durumlarını 'dır.
enum LoadingStatus { Init, Loading, Loaded, Error }
enum ApiStatus { success, fail, loading, wait, init }
enum BaseModelStatus { Ok, Error, Action, UnprocessableEntity, TimeOut }

