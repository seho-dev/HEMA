package com.hema.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/file")
public class FileAction {
	@RequestMapping("/text")
	public void fileText(@RequestParam("file") MultipartFile file, HttpServletResponse response, HttpServletRequest req)
			throws Exception {
		PrintWriter out = response.getWriter();
		if (!file.isEmpty()) {
			String path = req.getRealPath("/sdcard/");
			System.out.println(path);
			File our = new File(path);
			File backge = new File(path);
			// 查看是否存在目录
			String[] list = our.list();
			for (String item : list) {
				if (item.equals("sdcard")) {
					// 如果存在，就直接上传
					break;
				} else {
					// //创建文件夹，并且上传
					backge.mkdir();
					break;
				}
			}
			file.transferTo(new File(path + file.getOriginalFilename()));
			out.print("success");
		}
	}

	/**
	 * 查询全部已上传文件信息
	 */
	@RequestMapping("/all")
	public void getAllInformation(HttpServletResponse response, HttpServletRequest req) throws Exception {
		PrintWriter out = response.getWriter();
		response.setContentType("text/json;charset=utf-8");
		String path = req.getRealPath("/sdcard/");
		File file = new File(path);
		JSONArray json = new JSONArray();
		List<Object> files = null;
		// 循环列表
		File[] item = file.listFiles();
		for (File Item : item) {
			files = new ArrayList<Object>();
			// 获取文件名称
			files.add(Item.getName());
			files.add("/sdcard");
			// 获取时间
			files.add(Item.lastModified());
			// 获取下载链接
			files.add("/Hema-File/sdcard/" + Item.getName());
			json.add(files);
		}
		out.print(json);
	}

	/**
	 * 获取文件的信息内容
	 * 
	 */
	@RequestMapping("getfile/{name}")
	public ModelAndView getFile(@PathVariable("name") String name, HttpServletRequest req, HttpServletResponse response)
			throws Exception {
		// 通过io流逐条读取数据
		String path = req.getRealPath("/sdcard/" + name + ".txt");
		ModelAndView model = new ModelAndView("fileshow");
		File file = new File(path);
		BufferedReader filename = new BufferedReader(new FileReader(path));
		List<List<Object>> item = new ArrayList<List<Object>>();
		// 记录每行的信息
		List<Object> list = null;
		// 判断文件是否存在
		if (file.exists() && file.isFile()) {
			String line = null;
			// 第几行
			int page = 0;
			// 把一行的信息记录在集合里
			while ((line = filename.readLine()) != null) {
				page++;
				list = new ArrayList<Object>();
				// 存储到集合中
				list.add(page);
				list.add(line);
				list.add(name + ".txt");
				item.add(list);
			}
			model.addObject("list", item);
			filename.close();
		}
		return model;
	}

	/**
	 * 删除文本的某一行数据
	 */
	@RequestMapping("delete/{num}/{name}")
	public String deleteInfo(@PathVariable("num") int num, @PathVariable("name") String name, HttpServletRequest req)
			throws Exception {
		// 逐行读取文本
		String path = req.getRealPath("/sdcard/" + name + ".txt");
		BufferedReader filename = new BufferedReader(new FileReader(path));
		// 数字变量
		int page = 0;
		String line = null;
		// 得到新的数据替换原来的数据
		File newfile = new File(path);
		FileWriter fwriter = new FileWriter(newfile, true);
		List<String> list = new ArrayList<String>();
		while ((line = filename.readLine()) != null) {
			page++;
			if (page == num) {
				continue;
			} else {
				list.add(line);
			}
		}
		// 清空
		FileWriter middel = new FileWriter(newfile);
		fwriter.write("");
		// 添加
		for (String item : list) {
			fwriter.append(item + "\r\n");
		}
		fwriter.close();
		filename.close();
		return "forward:/file/getfile/" + name;
	}

	/**
	 * 修改内容
	 */
	@RequestMapping("update")
	public String updateInfo(String context, int id, String name, HttpServletRequest req,HttpServletResponse resp) throws IOException {
		// 获取文件名称，逐行读取
		String path = req.getRealPath("/sdcard/" + name);
		BufferedReader filename = new BufferedReader(new FileReader(path));
		List<String> list = new ArrayList<String>();
		String line = null;
		FileWriter fwriter = new FileWriter(new File(path), true);
		while ((line = filename.readLine()) != null) {
			// 所有的数据读取出来
			list.add(line);
		}
		// 清空所有数据
		FileWriter middel = new FileWriter(new File(path));
		fwriter.write("");
		// 通过循环循环出来
		int pages = 0;
		for (String item : list) {
			pages++;
			if (pages == id) {
				// 追加值
				fwriter.append(context + "\r\n");
				continue;
			} else {
				fwriter.append(item + "\r\n");
			}
		}
		fwriter.close();
		filename.close();
		name=name.substring(0, name.length()-4);
		System.out.println("文件名称"+name);
		return "forward:/file/getfile/" +name;
	}
}