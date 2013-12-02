component extends="model.abstract.AbstractIterator"{


	boolean function isforeignkey(){
		if (isprimarykey()){
			return false;
		}
		return ReFindNoCase("[a-z]_id$", get("COLUMNNAME")) != 0;
	}

	boolean function isprimarykey(){
		return get("ISPRIMARYKEY");
	}

}