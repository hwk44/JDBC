package membership;

public class MemberDTO {
	// 멤버 변수 선언
	// private 으로 선언해 다른 클래스에서 직접 접근 불가능하게 함.
	private String id;
	private String pass;
	private String name;
	private String regidate;
	
	
	// 멤버 변수별 게터와 세터
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegidate() {
		return regidate;
	}
	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}
	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", pass=" + pass + ", name=" + name + ", regidate=" + regidate + "]";
	}
	

	

	
}
