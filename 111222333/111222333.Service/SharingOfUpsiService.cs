public class SharingOfUpsiService : ISharingOfUpsiService
{
    private readonly ISharingOfUpsiRepository _sharingOfUpsiRepository;

    public SharingOfUpsiService(ISharingOfUpsiRepository sharingOfUpsiRepository)
    {
        _sharingOfUpsiRepository = sharingOfUpsiRepository;
    }

    public async Task<ICollection<SharingOfUpsiModel>> GetAllAsync()
    {
        return await _sharingOfUpsiRepository.GetAllAsync();
    }

    public async Task<SharingOfUpsiModel> GetByIdAsync(int id)
    {
        return await _sharingOfUpsiRepository.GetByIdAsync(id);
    }

    public async Task<SharingOfUpsiModel> CreateAsync(SharingOfUpsiModel model)
    {
        return await _sharingOfUpsiRepository.CreateAsync(model);
    }

    public async Task<SharingOfUpsiModel> UpdateAsync(SharingOfUpsiModel model)
    {
        return await _sharingOfUpsiRepository.UpdateAsync(model);
    }

    public async Task<bool> DeleteAsync(int id)
    {
        return await _sharingOfUpsiRepository.DeleteAsync(id);
    }
}