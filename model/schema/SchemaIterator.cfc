component extends="model.abstract.AbstractIterator"{

	boolean function iscompoundkey(){
		return get("ISCOMPOUNDKEY");
	}

	boolean function isforeignkey(){
		if (isprimarykey()){
			return false;
		}
		return ReFindNoCase("[a-z]_id$", get("COLUMNNAME")) != 0;
	}

	boolean function isprimarykey(){
		return get("ISPRIMARYKEY");
	}

	string function getkeytype(){
		if (isforeignkey()){
			return "Foreign Key";
		}
		else if (iscompoundkey()){
			return "Compound Key";
		}
		else if (isprimarykey()){
			return "Primary Key";
		}
		return "-";
	}

}