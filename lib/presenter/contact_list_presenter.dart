import 'package:mvp_app/model/contact_model.dart';
import 'package:mvp_app/repository/contact_repository.dart';
import 'package:mvp_app/util/injector.dart';

abstract class ContactListViewContract {
  void onLoadContactsComplete(List<Contact> items);
  void onLoadContactError();
}

class ContactListPresenter {
  ContactListViewContract _view;
  ContactRepository _repository;

  ContactListPresenter(this._view) {
    _repository = Injector().contactRepository;
  }

  void loadContacts() {
    assert(_view != null);

    _repository.fetch()
      .then((contacts) => _view.onLoadContactsComplete(contacts))
      .catchError((onError){
        print(onError);
        _view.onLoadContactError();
      });
  }
}